variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cluster_name" {
  description = "name of cluster to configure custom networking"
  type        = string
}

variable "secondary_cidr" {
  description = "The secondary CIDR block to associate with the VPC, must be /16 division or higher"
  type        = string
}

variable "secondary_subnets" {
  description = "A map where the `key` is the name of the availability zone and the `value` is the subnet CIDR"
  type        = map(any)
}