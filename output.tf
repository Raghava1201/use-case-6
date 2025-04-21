output "aurora_endpoint" {
  value = module.aurora_db.aurora_cluster_endpoint
}

output "aurora_reader_endpoint" {
  value = module.aurora_db.aurora_cluster_reader_endpoint
}

output "database_credentials_secret_arn" {
  value = module.aurora_db.secrets_manager_arn
}

output "database_security_group_id" {
  value = aws_security_group.aurora_sg.id
}