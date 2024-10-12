// Kubernetes Dashboard Configuration
resource "helm_release" "dashboard" {
  name      = var.kubernetes_dashboard_configuration.name
  namespace = var.kubernetes_dashboard_configuration.namespace

  repository       = var.kubernetes_dashboard_configuration.repository
  chart            = var.kubernetes_dashboard_configuration.chart
  version          = var.kubernetes_dashboard_configuration.version
  create_namespace = var.kubernetes_dashboard_configuration.create_namespace

}

// Kubernetes Dashboard Admin Configuration
resource "kubernetes_service_account" "admin_service_account" {
  metadata {
    name      = var.service_account_name
    namespace = var.kubernetes_dashboard_configuration.namespace
    labels = {
      app       = "dashboard"
      component = "serviceaccount"
    }
  }

  depends_on = [helm_release.dashboard]
}

resource "kubernetes_cluster_role_binding" "admin_service_account_role_binding" {
  metadata {
    name = var.service_account_name
    labels = {
      app       = "dashboard"
      component = "rolebinding"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = var.service_account_name
    namespace = var.kubernetes_dashboard_configuration.namespace
  }

  depends_on = [kubernetes_service_account.admin_service_account]
}
