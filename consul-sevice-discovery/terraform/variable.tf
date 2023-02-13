variable "instance_type" {
   type = string
   description = "EC2 Instance Type"
 }

 variable "tag" {
   type = string
   description = "The tag for the EC2 instance"
 }

 variable "region" {
   type = string
   description = "The project region"
   default = "eu-central1"
 }
