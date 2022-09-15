data "aws_route_table" "default" {
  subnet_id = var.DEFAULT_VPC_ID
}

output "test" {
  value = data.aws_route_table
}