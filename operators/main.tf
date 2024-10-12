// MinIO Operator Configuration
resource "helm_release" "minio" {
  name      = "minio-operator"
  namespace = "minio-operator"

  repository       = "https://operator.min.io"
  chart            = "operator"
  version          = "6.0.2"
  create_namespace = true

}
