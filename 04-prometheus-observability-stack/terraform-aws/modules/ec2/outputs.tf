output "instance_state" {
  description = "The state of the ec2 instance "
  value       = aws_instance.ec2_instance.*.instance_state
}

output "instance_public_dns" {
  description = "The Public DNS address of the ec2 instance"
  value       = aws_instance.ec2_instance.*.public_dns
}

output "instance_public_ip" {
  description = "The Public Ip address of the ec2 instance"
  value       = aws_instance.ec2_instance.*.public_ip
}
