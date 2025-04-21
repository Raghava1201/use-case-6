resource "aws_rds_cluster" "aurora1" {
  cluster_identifier      = var.cluster_name
  engine                  = var.engine
  engine_version          = var.engine_version
  database_name           = var.db_name
  master_username         = var.master_username
  master_password         = var.master_password
  vpc_security_group_ids  = var.security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.final_snapshot_identifier_prefix}-${var.cluster_name}-${replace(timestamp(), "/[^a-zA-Z0-9-]*/", "")}"
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count              = var.instance_count
  cluster_identifier = aws_rds_cluster.aurora1.id
  instance_class     = var.instance_type
  engine             = var.engine
  engine_version     = var.engine_version
  identifier         = "${var.cluster_name}-${count.index + 1}"
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "${var.cluster_name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_secretsmanager_secret" "aurora_credentials" {
  name = var.secrets_manager_name
}

resource "aws_secretsmanager_secret_version" "aurora_credentials_version" {
  secret_id   = aws_secretsmanager_secret.aurora_credentials.id
  secret_string = jsonencode({
    username = var.master_username
    password = var.master_password
    host     = aws_rds_cluster.aurora1.endpoint
    port     = aws_rds_cluster.aurora1.port
    dbname   = var.db_name
  })
}