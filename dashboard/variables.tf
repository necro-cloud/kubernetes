variable "kubernetes_dashboard_configuration" {
  description = "Dictionary filled with Kubernetes Dashboard Configuration Details"
  type        = map(string)
  default = {
    "name"             = "kubernetes-dashboard"
    "namespace"        = "kubernetes-dashboard"
    "repository"       = "https://kubernetes.github.io/dashboard/"
    "chart"            = "kubernetes-dashboard"
    "version"          = "7.8.0"
    "create_namespace" = true
  }
}

variable "service_account_name" {
  default     = "admin-user"
  description = "Kubernetes Dashboard Admin Service Account"
  type        = string
}
