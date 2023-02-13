variable "instance_type" {
   type = string
   description = "EC2 Instance Type"
 }

 variable "region" {
   type = string
   description = "The project region"
   default = "us-west-2"
 }

variable "ami" {
   type = string
   description = "The amazon machine image"
 }

variable "key_name" {
   type = string
   description = "Key Name"
 }
