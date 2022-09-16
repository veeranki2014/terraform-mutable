resource "aws_db_instance" "mysql" {
  allocated_storage               = 10
  db_name                         = "terraformdefault"
  engine                          = "mysql"
  engine_version                  = "5.7"
  instance_class                  = var.RDS_MYSQL_INSTANCE_TYPE
  username                        = "admin"
  password                        = "Roboshop123"
  parameter_group_name            = aws_db_parameter_group.mysql.name
  skip_final_snapshot             = true
  db_subnet_group_name            = aws_db_subnet_group.mysql.name
  identifier                      = "mysql-${var.ENV}"
  vpc_security_group_ids          = [aws_db_security_group.mysql.id]
}

resource "aws_db_parameter_group" "mysql" {
  name                            = "pg-for-${var.ENV}-mysql"
  family                          = "mysql5.7"
}

resource "aws_db_subnet_group" "mysql" {
  name                            = "mysql-${var.ENV}-subnet-group"
  subnet_ids                      = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS
  tags                            = {
    Name                          = "mysql-${var.ENV}-subnet-group"
  }
}

resource "aws_db_security_group" "mysql" {
  name                            = "mysql-${var.ENV}"
  ingress                                   {
    cidr                          = data.terraform_remote_state.vpc.outputs.VPC_PRIVATE_CIDR
  }
}