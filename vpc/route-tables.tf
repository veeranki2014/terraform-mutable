resource "aws_route_table" "public" {
  vpc_id                      = aws_vpc.main.id

  route {
    cidr_block                = "0.0.0.0/0"
    gateway_id                = aws_internet_gateway.igw.id
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

  tags                        = {
    Name                      = "${var.ENV}-private-rt"
  }
}



