terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.11.4"
  random = {
    source  = "hashicorp/random"
    version = "~> 3.0"
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_password" "master" {
  length          = 16
  special         = true
  override_special = "!#$%&*()-_=+[]{}?:."
}

resource "aws_security_group" "aurora_sg" {
  name        = "${var.project_name}-aurora-sg"
  vpc_id      = var.vpc_id
  description = "Security group for AuroraDB access"

  ingress {
    description = "Allow MySQL/PostgreSQL access from specific IP"
    from_port   = var.aurora_engine == "aurora-mysql" ? 3306 : 5432
    to_port     = var.aurora_engine == "aurora-mysql" ? 3306 : 5432
    protocol    = "tcp"
    cidr_blocks = ["148.64.4.52/32"]
  }

  ingress {
    description = "Allow traffic within the VPC (adjust as needed)"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["172.31.32.0/20"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-aurora-sg"
  }
}

module "aurora_db" {
  source = "./modules/aurora-cluster"

  cluster_name                = "${var.project_name}-aurora"
  engine                      = var.aurora_engine
  engine_version              = var.aurora_engine_version
  instance_type               = var.aurora_instance_type
  instance_count              = var.aurora_instance_count
  db_name                     = var.aurora_db_name
  master_username             = var.aurora_master_username
  master_password             = random_password.master.result
  vpc_id                      = var.vpc_id
  subnet_ids                  = var.private_subnet_ids
  security_group_ids          = [aws_security_group.aurora_sg.id]
  secrets_manager_name        = var.secrets_manager_db_name
  deletion_protection         = false
  skip_final_snapshot         = false
  final_snapshot_identifier_prefix = "final"
}
