resource "aws_subnet" "private" {
  count               = length(var.PRIVATE_SUBNET_CIDRS)
  vpc_id              = aws_vpc.main.id
  cidr_block          = element(var.PRIVATE_SUBNET_CIDRS, count.index)

  tags                = {
    Name              = "${var.ENV}-private-${count.index+1}"
  }
}

resource "aws_subnet" "public" {
  depends_on          = [aws_vpc_ipv4_cidr_block_association.public_cidr]
  count               = length(var.PUBLIC_SUBNET_CIDRS)
  vpc_id              = aws_vpc.main.id
  cidr_block          = element(var.PUBLIC_SUBNET_CIDRS, count.index)

  tags                = {
    Name              = "${var.ENV}-public-${count.index+1}"
  }
}