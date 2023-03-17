resource "aws_secretsmanager_secret" "rds_secret" {
  name = "/dev/petclinic/db"
}

resource "random_password" "password" {
  length           = 8
  special          = true
  override_special = "_@%"
}

resource "aws_secretsmanager_secret_version" "rds_secret_value" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = "petclinic",
    password = random_password.password.result,
  })
}

# Create a DB security group
resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_instance" "rds_instance" {
  identifier               = "petclinic-mysql-rds"
  engine                   = "mysql"
  instance_class           = "db.t2.micro"
  allocated_storage        = 10
  storage_type             = "gp2"
  username                 = jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["username"]
  password                 = jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["password"]
  db_subnet_group_name     = "default"
  vpc_security_group_ids   = [aws_security_group.rds_security_group.id]
  backup_retention_period  = 7
  delete_automated_backups = true
  copy_tags_to_snapshot    = true
  publicly_accessible      = true
  skip_final_snapshot      = true
  apply_immediately        = true

  tags = {
    Name = "petclinic-rds"
  }

}

# Data source to retrieve RDS endpoint
data "aws_db_instance" "rds_instance" {
  db_instance_identifier = aws_db_instance.rds_instance.id
}


resource "aws_ssm_parameter" "rds_endpoint" {
  name  = "/dev/petclinic/rds_endpoint"
  type  = "String"
  value = data.aws_db_instance.rds_instance.endpoint
}
