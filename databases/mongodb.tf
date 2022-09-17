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

resource "aws_ec2_tag" "mango-name-tag" {
  resource_id                 = aws_spot_instance_request.mongodb.spot_instance_id
  key                         = "Name"
  value                       = "mongodb-${var.ENV}"
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
  ingress                    {
    description               = "MONGODB"
    from_port                 = 27017
    to_port                   = 27017
    protocol                  = "tcp"
    cidr_blocks               = [data.terraform_remote_state.vpc.outputs.VPC_PRIVATE_CIDR]
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

resource "null_resource" "mongodb-apply" {
  provisioner "remote-exec" {
    connection {
      host                     = aws_spot_instance_request.mongodb.private_ip
      user                     = "centos"
      password                 = "DevOps321"
    }
      inline = [
        "sudo yum install python3-pip -y",
        "sudo pip3 install pip --upgrade",
        "sudo pip3 install ansible==4.1.0",
        "ansible-pull -i localhost, -U https://veeranki20144891@dev.azure.com/veeranki20144891/DevOps/_git/ansible roboshop-pull.yml -e COMPONENT=mongodb -e ENV=${var.ENV}"
      ]
    }
}

resource "aws_route53_record" "mongodb" {
  zone_id                       = data.terraform_remote_state.vpc.outputs.INTERNAL_DNS_ZONE_ID
  name                          = "mongodb-${var.ENV}.roboshop.internal"
  type                          = "A"
  ttl                           = 300
  records                       = [aws_spot_instance_request.mongodb.private_ip]
}