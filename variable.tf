variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "bayer-aurora-project"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to deploy into"
  default = "vpc-06cab60814e52bf9c"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of private subnet IDs for the Aurora cluster"
  default = ["subnet-0d60f17ef3c678f24", "subnet-0d8aaf049924e623f"]
}

variable "aurora_engine" {
  type    = string
  default = "aurora-mysql"
}

variable "aurora_engine_version" {
  type    = string
  default = "5.7.mysql_aurora.2.12.5"
}

variable "aurora_instance_type" {
  type    = string
  default = "db.t3.medium"
}

variable "aurora_instance_count" {
  type    = number
  default = 2
}

variable "aurora_db_name" {
  type    = string
  default = "bayerdb"
}

variable "aurora_master_username" {
  type    = string
  default = "admin"
}

variable "secrets_manager_db_name" {
  type    = string
  default = "bayer-aurora-credentials-1"
}