// MinIO Operator Configuration
resource "helm_release" "minio" {
  name      = var.minio_operator_configuration.name
  namespace = var.minio_operator_configuration.namespace

  repository       = var.minio_operator_configuration.repository
  chart            = var.minio_operator_configuration.chart
  version          = var.minio_operator_configuration.version
  create_namespace = var.minio_operator_configuration.create_namespace

}

// Cert Manager Operator Configuration
resource "helm_release" "cert-manager" {
  name      = var.cert_manager_configuration.name
  namespace = var.cert_manager_configuration.namespace

  repository       = var.cert_manager_configuration.repository
  chart            = var.cert_manager_configuration.chart
  version          = var.cert_manager_configuration.version
  create_namespace = var.cert_manager_configuration.create_namespace

  set {
    name  = "crds.enabled"
    value = true
  }

}

// Cloud Native PG Operator Configuration
resource "helm_release" "cnpg" {
  name      = var.cnpg_configuration.name
  namespace = var.cnpg_configuration.namespace

  repository       = var.cnpg_configuration.repository
  chart            = var.cnpg_configuration.chart
  version          = var.cnpg_configuration.version
  create_namespace = var.cnpg_configuration.create_namespace

}

// NGINX Ingress Controller Configuration
resource "helm_release" "nginx" {
  name      = var.nginx_configuration.name
  namespace = var.nginx_configuration.namespace

  repository       = var.nginx_configuration.repository
  chart            = var.nginx_configuration.chart
  version          = var.nginx_configuration.version
  create_namespace = var.nginx_configuration.create_namespace

}
