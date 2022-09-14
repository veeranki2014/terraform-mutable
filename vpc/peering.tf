resource "aws_vpc_peering_connection" "to-default-vpc" {
  peer_vpc_id         = aws_vpc.main.id
  vpc_id              = var.DEFAULT_VPC_ID
  auto_accept         = true
  tags                = {
    Name              = "${var.ENV}-vpc-peer-to-default"

  }
}