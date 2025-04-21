variable "cluster_name" {
  type        = string
  description = "The name of the Aurora cluster"
  default     = "bayer-aurora-cluster"
}

variable "engine" {
  type        = string
  description = "The database engine type\n(e.g., aurora-mysql, aurora-postgresql)"
  default     = "aurora-mysql"
}

variable "engine_version" {
  type        = string
  description = "The database engine version"
}

variable "instance_type" {
  type        = string
  description = "The instance type for the Aurora instances"
  default     = "db.t3.small"
}

variable "instance_count" {
  type        = number
  description = "The number of Aurora instances to create"
  default     = 2
}

variable "db_name" {
  type        = string
  description = "The name of the initial database"
  default     = "bayerdb"
}

variable "master_username" {
  type        = string
  description = "The master username for the Aurora cluster"
}

variable "master_password" {
  type        = string
  description = "The master password for the Aurora cluster"
  sensitive   = true
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to deploy into"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to deploy the Aurora cluster into"
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate with the Aurora cluster"
}

variable "secrets_manager_name" {
  type        = string
  description = "The name to use for the secret in AWS Secrets Manager"
  default     = "aurora-db-credentials"
}

variable "deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection for the Aurora cluster"
  default     = true
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Whether to skip the final snapshot before deleting the Aurora cluster"
  default     = true
}

variable "final_snapshot_identifier_prefix" {
  type        = string
  description = "The prefix for the final snapshot identifier"
  default     = "final-snapshot"
}