output "VPC_ID" {
  value = aws_vpc.main.id
}
output "VPC_PRIVATE_CIDR" {
  value = var.VPC_PRIVATE_CIDR
}

output "PRIVATE_SUBNET_CIDRS" {
  value = var.PRIVATE_SUBNET_CIDRS
}

output "SUBNET_AZ" {
  value = var.SUBNET_AZ
}

output "VPC_PUBLIC_CIDR" {
  value = var.VPC_PUBLIC_CIDR
}

output "PUBLIC_SUBNET_CIDRS" {
  value = var.PUBLIC_SUBNET_CIDRS
}

output "DEFAULT_VPC_ID" {
  value = var.DEFAULT_VPC_ID
}

output "DEFAULT_VPC_CIDR" {
  value = var.DEFAULT_VPC_CIDR
}

output "PRIVATE_SUBNETS" {
  value = aws_subnet.private.*.id
}

output "PUBLIC_SUBNETS" {
  value = aws_subnet.public.*.id
}


