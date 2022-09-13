resource "aws_subnet" "private" {
  count               = length(var.PRIVATE_SUBNET_CIDRS)
  vpc_id              = aws_vpc.main.id
  cidr_block          = element(var.PRIVATE_SUBNET_CIDRS, count.index)

  tags                = {
    Name              = "private-${count.index+1}"
  }
}

resource "aws_subnet" "public" {
  count               = length(var.PUBLIC_SUBNET_CIDRS)
  vpc_id              = aws_vpc.main.id
  cidr_block          = element(var.PUBLIC_SUBNET_CIDRS, count.index)

  tags                = {
    Name              = "public-${count.index+1}"
  }
}