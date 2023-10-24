output "rds_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.rds_instance.address
}

output "rds_endpoint" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}

output "master_user_secret" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.rds_instance.master_user_secret[0].secret_arn
}
