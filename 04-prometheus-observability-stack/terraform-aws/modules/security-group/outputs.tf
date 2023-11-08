output "security_group_ids" {
  description = "ID of the security group."
  value       = aws_security_group.instance_sg.*.id
}