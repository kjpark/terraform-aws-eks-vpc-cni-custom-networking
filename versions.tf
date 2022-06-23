terraform {
  required_version = ">= 1.2.0, < 2.0.0"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

provider "kubectl" {
  config_path    = "~/.kube/config"
  config_context = data.aws_eks_cluster.this.arn
}