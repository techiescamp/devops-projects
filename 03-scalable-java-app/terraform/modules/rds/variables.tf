variable "update_rds_endpoint" {
  type    = bool
  default = true
}

variable "region" {
    default = "us-west-2"
}

variable "secret_name" {
  description = "The name of secrets manager secret"
  type    = string
}

variable "db_username" {
  description = "The username for the RDS database"
  type    = string
}

variable "db_name" {
  description = "The identifier for the RDS instance"
  type    = string
}

variable "db_instance_class" {
  description = "The RDS instance class"
  type    = string
}

variable "parameter_name" {
  description = "The RDS instance class"
  type    = string
}