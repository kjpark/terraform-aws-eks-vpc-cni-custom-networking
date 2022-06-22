terraform {
  required_version = ">= 1.2.0, < 2.0.0"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
}

provider "kubernetes" {
 config_path    = "~/.kube/config"
 config_context = data.aws_eks_cluster.this.arn
}

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

resource "kubernetes_manifest" "eniconfig" {
  for_each = var.secondary_subnets
  manifest = {
    "apiVersion" = "crd.k8s.amazonaws.com/v1alpha1"
    "kind" = "ENIConfig"
    "metadata" = {
      "name" = "${each.key}"
    }
    "spec" = {
      "securityGroups" = [
        "${data.aws_eks_cluster.this.vpc_config[*].cluster_security_group_id}",
      ]
      "subnet" = "${aws_subnet.secondary_subnet[each.key].id}"
    }
  }
  # attempted bug workaround?
  # computed_fields = ["spec.securityGroups[0]"]
}
