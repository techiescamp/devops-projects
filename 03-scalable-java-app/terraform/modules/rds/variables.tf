variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the RDS resources"
}

variable "region" {
  type    = string
}

variable "secret_name" {
  description = "The name of secrets manager secret"
  type    = string
}

variable "password_length" {
  description = "Length of the password"
  type    = number
}

variable "special_characters" {
  description = "Need to add any special characters"
  type    = bool
}

variable "override_special" {
  description = "Type of special characters to override"
  type    = string
}

variable "db_username" {
  description = "The username for the RDS database"
  type    = string
}

variable "ingress_from_port" {
  description = "Length of the password"
  type    = number
}

variable "ingress_to_port" {
  description = "Length of the password"
  type    = number
}

variable "ingress_protocol" {
  description = "Length of the password"
  type    = string
}

variable "ingress_cidr_blocks" {
  description = "Length of the password"
  type    = list(string)
}

variable "egress_from_port" {
  description = "Length of the password"
  type    = number
}

variable "egress_to_port" {
  description = "Length of the password"
  type    = number
}

variable "egress_protocol" {
  description = "Length of the password"
  type    = string
}

variable "egress_cidr_blocks" {
  description = "Length of the password"
  type    = list(string)
}

variable "db_engine" {
  description = "RDS db engine"
  type    = string
}

variable "db_instance_class" {
  description = "The RDS instance class"
  type    = string
}

variable "db_storage" {
  description = "DB storage size"
  type    = number
}

variable "db_storage_type" {
  description = "DB storage type"
  type    = string
}

variable "db_subnet_group" {
  description = "DB subnet group"
  type    = string
}

variable "backup_retention_period" {
  description = "DB backup retention period"
  type    = number
}

variable "delete_automated_backups" {
  description = "Delete all backups"
  type    = bool
}

variable "copy_tags_to_snapshot" {
  description = "Copy tags to snapshot"
  type    = bool
}

variable "publicly_accessible" {
  description = "Public accessability"
  type    = bool
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type    = bool
}

variable "apply_immediately" {
  description = "Apply immediately"
  type    = bool
}

variable "parameter_name" {
  description = "The RDS instance class"
  type    = string
}

variable "parameter_type" {
  description = "Parameter type"
  type    = string
}

variable "environment" {
  type        = string
  description = "The environment name for the resources."
}

variable "owner" {
  type        = string
  description = "Name of the owner for this RDS"
}

variable "application" {
  type        = string
  description = "Name of the application"
}

variable "cost_center" {
  type        = string
  description = "Name of cost-center for this RDS"
}