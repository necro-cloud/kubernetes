variable "cloudflare_email" {
  description = "Email Address to be used for DNS Challenge"
  type        = string
  sensitive   = true
}

variable "cloudflare_token" {
  description = "Token to be used for DNS Challenge"
  type        = string
  sensitive   = true
}

variable "minio_operator_namespace" {
  default     = "minio-operator"
  description = "Namespace to be used for deploying MinIO Tenant and related resources."
}

variable "cluster_issuer_name" {
  default     = "photoatom-self-signed-issuer"
  description = "Name for the Cluster Issuer for Self Signed Certificates"
}

variable "public_cluster_issuer_name" {
  default     = "photoatom-issuer"
  description = "Name for the Cluster Issuer for Public Facing Certificates"
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
