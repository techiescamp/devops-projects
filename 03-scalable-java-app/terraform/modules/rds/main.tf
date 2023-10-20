resource "aws_secretsmanager_secret" "rds_secret" {
  name = var.secret_name
}

resource "random_password" "password" {
  length           = var.password_length
  special          = var.special_characters
  override_special = var.override_special
}

resource "aws_secretsmanager_secret_version" "rds_secret_value" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.db_username,
    password = random_password.password.result,
  })
}

# Create a DB security group
resource "aws_security_group" "rds_security_group" {
  name        = "${var.environment}-${var.application}-rds-sg"
  description = "Security group for RDS instance"

  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }
}


resource "aws_db_instance" "rds_instance" {
  identifier               = "${var.environment}-${var.application}-rds-sg"
  engine                   = var.db_engine
  instance_class           = var.db_instance_class
  allocated_storage        = var.db_storage
  storage_type             = var.db_storage_type
  username                 = jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["username"]
  password                 = jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["password"]
  db_subnet_group_name     = var.db_subnet_group
  vpc_security_group_ids   = [aws_security_group.rds_security_group.id]
  backup_retention_period  = var.backup_retention_period
  delete_automated_backups = var.delete_automated_backups
  copy_tags_to_snapshot    = var.copy_tags_to_snapshot
  publicly_accessible      = var.publicly_accessible
  skip_final_snapshot      = var.skip_final_snapshot
  apply_immediately        = var.apply_immediately

  tags = merge(
  {
    Name        = "${var.environment}-${var.application}-ssm",
    Environment = var.environment,
    Owner       = var.owner,
    CostCenter  = var.cost_center,
    Application = var.application,
  },
  var.tags
  )

}

# Data source to retrieve RDS endpoint
data "aws_db_instance" "rds_instance" {
  db_instance_identifier = aws_db_instance.rds_instance.id
}


resource "aws_ssm_parameter" "rds_endpoint" {
  name  = var.parameter_name
  type  = var.parameter_type
  value = data.aws_db_instance.rds_instance.endpoint
}
