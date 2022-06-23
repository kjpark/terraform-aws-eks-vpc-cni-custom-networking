data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

resource "kubectl_manifest" "eniconfig" {
  for_each  = var.secondary_subnets
  yaml_body = <<-YAML
  apiVersion: crd.k8s.amazonaws.com/v1alpha1
  kind: ENIConfig
  metadata: 
    name: ${each.key}
    namespace: default
  spec: 
    securityGroups: 
      - ${data.aws_eks_cluster.this.vpc_config[0].cluster_security_group_id}
    subnet: ${aws_subnet.secondary_subnet[each.key].id}
  YAML
}

resource "null_resource" "enable_custom_networking" {
  provisioner "local-exec" {
    command = "kubectl set env daemonset aws-node -n kube-system AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG=true ENI_CONFIG_LABEL_DEF=topology.kubernetes.io/zone"
  }
}