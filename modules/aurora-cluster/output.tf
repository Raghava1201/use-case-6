output "aurora_cluster_endpoint" {
  value       = aws_rds_cluster.aurora1.endpoint
  description = "The endpoint of the Aurora cluster"
}

output "aurora_cluster_reader_endpoint" {
  value       = aws_rds_cluster.aurora1.reader_endpoint
  description = "The reader endpoint of the Aurora cluster"
}

output "secrets_manager_arn" {
  value       = aws_secretsmanager_secret.aurora_credentials.arn
  description = "The ARN of the Secrets Manager secret containing the Aurora credentials"
}