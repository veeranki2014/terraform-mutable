data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "^base-image"
  //name_regex       = "^Centos*"
  //owners           = ["973714476881"]
  owners           = ["self"]
}

data "terraform_remote_state" "vpc" {
  backend               = "s3"
  config                = {
    bucket              = "terraform-roboshop"
    key                 = "mutable/vpc/${var.ENV}/terraform.tfstate"
    region              = "us-east-1"

    }
  }
