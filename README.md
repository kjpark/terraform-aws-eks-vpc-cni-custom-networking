# terraform-aws-eks-vpc-cni-custom-networking
This terraform module configures aws eks vpc cni k8s custom networking to assign non-routable ip's from the 100.64.0.0/10 and 198.19.0.0/16 secondary CIDR ranges to kubernetes pods.

This module must be applied to an existing cluster.

This module automates the process described in [these docs](https://docs.aws.amazon.com/eks/latest/userguide/cni-custom-network.html#custom-networking-configure-kubernetes) on setting up custom networking.

## Usage

Example input to set up secondary cidr ranges in 4 az's

```
cluster_name = "mycluster"
vpc_id       = "vpc-123123abcabc"

secondary_cidr = "100.64.0.0/16"
secondary_subnets = {
  us-east-1a = "100.64.0.0/18"
  us-east-1b = "100.64.64.0/18"
  us-east-1c = "100.64.128.0/18"
  us-east-1d = "100.64.192.0/18"
}
```