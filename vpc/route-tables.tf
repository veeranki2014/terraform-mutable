resource "aws_route_table" "public" {
  vpc_id                      = aws_vpc.main.id

  route {
    cidr_block                = "0.0.0.0/0"
    gateway_id                = aws_internet_gateway.igw.id
  }
  route {
    vpc_peering_connection_id = aws_vpc_peering_connection.to-default-vpc.id
    cidr_block                = var.DEFAULT_VPC_CIDR
  }

  tags                        = {
    Name                      = "${var.ENV}-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id                      = aws_vpc.main.id

  route {
    cidr_block                = "0.0.0.0/0"
    gateway_id                = aws_nat_gateway.ngw.id
  }
  route {
    vpc_peering_connection_id = aws_vpc_peering_connection.to-default-vpc.id
    cidr_block                = var.DEFAULT_VPC_CIDR
  }

  tags                        = {
    Name                      = "${var.ENV}-private-rt"
  }
}



