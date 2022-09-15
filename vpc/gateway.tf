resource "aws_internet_gateway" "igw" {
  vpc_id               = aws_vpc.main.id
  tags                 = {
    Name               = "${var.ENV}-igw"
  }
}

resource "aws_eip" "ngw" {
    vpc               = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id         = aws_eip.ngw.id
  subnet_id             = aws_subnet.public.*.id[0]
  tags                  = {
    Name                = "${var.ENV}-ngw"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on            = [aws_internet_gateway.igw]
}