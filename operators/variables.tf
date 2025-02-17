variable "minio_operator_configuration" {
  description = "Dictionary filled with MinIO Operator Configuration Details"
  type        = map(string)
  default = {
    "name"             = "minio-operator"
    "namespace"        = "minio-operator"
    "repository"       = "https://operator.min.io"
    "chart"            = "operator"
    "version"          = "6.0.4"
    "create_namespace" = true
  }
}

variable "cert_manager_configuration" {
  description = "Dictionary filled with Cert Manager Operator Configuration Details"
  type        = map(string)
  default = {
    "name"             = "cert-manager"
    "namespace"        = "cert-manager"
    "repository"       = "https://charts.jetstack.io"
    "chart"            = "cert-manager"
    "version"          = "v1.16.1"
    "create_namespace" = true
  }
}

variable "cnpg_configuration" {
  description = "Dictionary filled with Cloud Native PG Operator Configuration Details"
  type        = map(string)
  default = {
    "name"             = "cnpg"
    "namespace"        = "cnpg-system"
    "repository"       = "https://cloudnative-pg.github.io/charts"
    "chart"            = "cloudnative-pg"
    "version"          = "v0.22.0"
    "create_namespace" = true
  }
}

variable "nginx_configuration" {
  description = "Dictionary filled with NGINX Controller Configuration Details"
  type        = map(string)
  default = {
    "name"             = "ingress-nginx"
    "namespace"        = "ingress-nginx"
    "repository"       = "https://kubernetes.github.io/ingress-nginx"
    "chart"            = "ingress-nginx"
    "version"          = "4.11.2"
    "create_namespace" = true
  }
}

variable "replicator_configuration" {
  description = "Dictionary filled with Kubernetes Replicator Configuration Details"
  type        = map(string)
  default = {
    "name"             = "kubernetes-replicator"
    "namespace"        = "kubernetes-replicator"
    "repository"       = "https://helm.mittwald.de"
    "chart"            = "kubernetes-replicator"
    "version"          = "2.11.0"
    "create_namespace" = true
  }
}
