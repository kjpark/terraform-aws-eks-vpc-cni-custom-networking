# terraform-aws-eks-vpc-cni-custom-networking
terraform module to configure aws eks vpc cni k8s custom networking to assign non-routable ip's from the 100.64.0.0/10 and 198.19.0.0/16 secondary CIDR ranges to kubernetes pods

# sketch

## inputs
**required**
- vpc id
- cluster name

**optional**
- Secondary CIDR | 100.64.0.0/10
- Subnets | divide ~evenly among used az's

# overview

REF:
- [AWS EKS Tutorial: Custom Networking](https://docs.aws.amazon.com/eks/latest/userguide/cni-custom-network.html#custom-networking-configure-vpc)
- [EKS Workshop: Using Secondary CIDRs with EKS](https://www.eksworkshop.com/beginner/160_advanced-networking/secondary_cidr/)
- [Helpful README](https://github.com/tushardashpute/vpc-cni)

## 1. Configure VPC

- associate secondary CIDR to VPC
- divide 2nd CIDR into subnets

## 2. Configure Custom Networking

- check CNI version and CRD for ENIConfig
- retrieve cluster sg ID
- create ENIConfig per subnet (us-east-1a.yaml)
- enable custom networking

## dump

```
AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG=true
ENI_CONFIG_LABEL_DEF=failure-domain.beta.kubernetes.io/zone
ENI_CONFIG_LABEL_DEF=topology.kubernetes.io/zone
AWS_VPC_K8S_CNI_EXTERNALSNAT=false
```
