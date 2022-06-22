resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = var.vpc_id
  cidr_block = var.secondary_cidr
}

resource "aws_subnet" "secondary_subnet" {
  vpc_id = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id

  for_each          = var.secondary_subnets
  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "secondary-${each.key}"
  }
}