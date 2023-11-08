output "instance_state" {
  description = "The state of the ec2 instance "
  value       = module.ec2.instance_state
}

output "instance_public_dns" {
  description = "The Public DNS address of the ec2 instance"
  value       = module.ec2.instance_public_dns
}

output "instance_public_ip" {
  description = "The Public Ip address of the ec2 instance"
  value       = module.ec2.instance_public_ip
}

