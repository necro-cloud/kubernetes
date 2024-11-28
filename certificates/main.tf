resource "kubernetes_manifest" "cluster_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "${var.cluster_issuer_name}"
      "labels" = {
        "app"       = "base"
        "component" = "clusterissuer"
      }
    }
    "spec" = {
      "selfSigned" = {}
    }
  }
}

// Certificate Authority to be used with MinIO Operator
resource "kubernetes_manifest" "minio_ca" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Certificate"
    "metadata" = {
      "name"      = "${var.minio_operator_ca_name}"
      "namespace" = "${var.minio_operator_namespace}"
      "labels" = {
        "app"       = "minio-operator"
        "component" = "ca"
      }
    }
    "spec" = {
      "isCA" = true
      "subject" = {
        "organizations"       = ["photoatom"]
        "countries"           = ["India"]
        "organizationalUnits" = ["MinIO Operator"]
      }
      "commonName" = "operator"
      "secretName" = "operator-ca-tls"
      "duration"   = "70128h"
      "privateKey" = {
        "algorithm" = "ECDSA"
        "size"      = 256
      }
      "issuerRef" = {
        "name"  = "${var.cluster_issuer_name}"
        "kind"  = "ClusterIssuer"
        "group" = "cert-manager.io"
      }
    }
  }

  depends_on = [kubernetes_manifest.cluster_issuer]
}

// Issuer for the MinIO Operator Namespace
resource "kubernetes_manifest" "minio_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Issuer"
    "metadata" = {
      "name"      = "${var.minio_operator_issuer_name}"
      "namespace" = "${var.minio_operator_namespace}"
      "labels" = {
        "app"       = "minio-operator"
        "component" = "issuer"
      }
    }
    "spec" = {
      "ca" = {
        "secretName" = "operator-ca-tls"
      }
    }
  }

  depends_on = [kubernetes_manifest.minio_ca]
}

// Certificate for MinIO STS
resource "kubernetes_manifest" "sts_certificate" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Certificate"
    "metadata" = {
      "name"      = "${var.minio_operator_sts_certificate_name}"
      "namespace" = "${var.minio_operator_namespace}"
      "labels" = {
        "app"       = "minio"
        "component" = "certificate"
      }
    }
    "spec" = {
      "subject" = {
        "organizations"       = ["photoatom"]
        "countries"           = ["India"]
        "organizationalUnits" = ["MinIO Operator"]
      }
      "commonName" = "sts"
      "dnsNames" = [
        "sts",
        "sts.minio-operator.svc",
        "sts.minio-operator.svc.cluster.local"
      ]
      "secretName" = "sts-tls"
      "issuerRef" = {
        "name" = "${var.minio_operator_issuer_name}"
      }
    }
  }

  depends_on = [kubernetes_manifest.minio_issuer]
}
