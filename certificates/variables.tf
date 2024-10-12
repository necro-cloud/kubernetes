variable "minio_operator_namespace" {
  default     = "minio-operator"
  description = "Namespace to be used for deploying MinIO Tenant and related resources."
}

variable "cluster_issuer_name" {
  default     = "photoatom-issuer"
  description = "Name for the Cluster Issuer"
}

variable "minio_operator_ca_name" {
  default     = "operator-ca-certificate"
  description = "Name for the Certificate Authority for MinIO Operator"
}

variable "minio_operator_issuer_name" {
  default     = "operator-ca-issuer"
  description = "Name for the Issuer for MinIO Operator"
}

variable "minio_operator_sts_certificate_name" {
  default     = "sts-certmanager-cert"
  description = "Name for the certificate for MinIO STS"
}
