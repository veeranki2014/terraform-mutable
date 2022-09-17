resource "aws_elasticache_cluster" "redis" {
  cluster_id                      = "redis-${var.ENV}"
  engine                          = "redis"
  node_type                       = var.REDIS_INSTANCE_TYPE
  num_cache_nodes                 = 1
  parameter_group_name            = "default.redis6.x"
  engine_version                  = "6.x"
  port                            = 6379
  subnet_group_name               = aws_elasticache_subnet_group.redis.name
  security_group_ids              = [aws_elasticache_security_group.redis.name]
}

resource "aws_elasticache_security_group" "redis" {
  name                 = "redis-${var.ENV}-subnet-group"
  security_group_names = [aws_security_group.allow_redis.name]
}

resource "aws_elasticache_subnet_group" "redis" {
  name                            = "redis-${var.ENV}-subnet-group"
  subnet_ids                      = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS
  tags                            = {
    Name                          = "redis-${var.ENV}-subnet-group"
  }
}

resource "aws_security_group" "allow_redis" {
  name                            = "allow_redis_${var.ENV}"
  description                     = "allow_redis_${var.ENV}"
  vpc_id                          = data.terraform_remote_state.vpc.outputs.VPC_ID
  ingress                         {
    description                   = "REDIS"
    from_port                     = 6379
    to_port                       = 6379
    protocol                      = "tcp"
    cidr_blocks                   = [data.terraform_remote_state.vpc.outputs.VPC_PRIVATE_CIDR]
  }
  egress                          {
    from_port                     = 0
    to_port                       = 0
    protocol                      = "-1"
    cidr_blocks                   = ["0.0.0.0/0"]
  }
  tags                            = {
    Name                          = "allow_redis_${var.ENV}"
    Environment                   = var.ENV
  }
}

/*
resource "aws_route53_record" "redis" {
  zone_id                       = data.terraform_remote_state.vpc.outputs.INTERNAL_DNS_ZONE_ID
  name                          = "mysql-${var.ENV}.roboshop.internal"
  type                          = "CNAME"
  ttl                           = 300
  records                       = [aws_db_instance.mysql.address]
}
*/

output "redis" {
  value = aws_elasticache_cluster.redis
}
