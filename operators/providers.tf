terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.16.1"
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
