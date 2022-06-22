variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cluster_name" {
  description = "name of cluster to configure custom networking"
  type        = string
}

variable "secondary_cidr" {
  description = "secondary cidr block for vpc"
  type        = string
}

variable "secondary_subnets" {
  description = "secondary subnet az ranges"
  type        = map(any)
}