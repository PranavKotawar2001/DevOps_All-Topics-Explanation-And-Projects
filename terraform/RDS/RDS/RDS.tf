# Using default VPC
data "aws_vpc" "default" {
  default = true
}

# Using Dafault subnet
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


# Security group for RDS

resource "aws_security_group" "RDS_security_group" {
    vpc_id = data.aws_vpc.default.id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        name = "RDS_security_group"
    }
}


# Subnet group for RDS
resource "aws_db_subnet_group" "default" {
  name       = "default-db-subnet-group"
  subnet_ids = data.aws_subnets.default.ids
  tags = {
    Name        = "default-db-subnet-group"
  }
}


# Creating RDS
resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage 
  max_allocated_storage = var.max_allocated_storage 
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class
  username             = var.username  
  password             = var.password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.RDS_security-group.id]
  db_subnet_group_name = aws_db_subnet_group.default.name
  tags = {
    name = "RDS-db-insytancee"
  }
}