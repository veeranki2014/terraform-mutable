resource "aws_vpc" "main" {
  cidr_block            = var.VPC_PRIVATE_CIDR
 tags                   = {
    Name                = "${var.ENV}-vpc"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "public_cidr" {
  vpc_id                = aws_vpc.main.id
  cidr_block            = var.VPC_PUBLIC_CIDR
}