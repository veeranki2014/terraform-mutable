# Request a spot instance at $0.03
resource "aws_spot_instance_request" "mongodb" {
  ami                         = data.aws_ami.ami.id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.allow_mongodb.id]
  subnet_id                   = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS[0]
  wait_for_fulfillment        = true
    tags                      = {
      Name                    = "mangodb-${var.ENV}"
    }
}

resource "aws_security_group" "allow_mongodb" {
  name                        = "allow_mangodb_${var.ENV}"
  description                 = "allow_mangodb_${var.ENV}"
  vpc_id                      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress                    {
    description               = "SSH"
    from_port                 = 22
    to_port                   = 22
    protocol                  = "tcp"
    cidr_blocks               = [data.terraform_remote_state.vpc.outputs.VPC_PRIVATE_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
   }

  egress                      {
    from_port                 = 0
    to_port                   = 0
    protocol                  = "-1"
    cidr_blocks               = ["0.0.0.0/0"]
  }

  tags                        = {
    Name                      = "mangodb-${var.ENV}"
    Environment               = var.ENV
  }
}