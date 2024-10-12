terraform {
  required_providers {
    kubernetes = {
      source  = "opentofu/kubernetes"
      version = "2.32.0"
    }
    helm = {
      source  = "opentofu/helm"
      version = "2.15.0"
    }
  }

  backend "kubernetes" {
    secret_suffix = "operators.base"
  }
}

provider "kubernetes" {

}

provider "helm" {

}
