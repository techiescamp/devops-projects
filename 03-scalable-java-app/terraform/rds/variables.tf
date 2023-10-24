variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the RDS resources"
}

variable "update_rds_endpoint" {
  type    = bool
  default = true
}

variable "region" {
  type        = string
  description = "Region of the rds"
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

variable "db_username" {
  description = "The username for the RDS database"
  type        = string
}

variable "set_secret_manager_password" {
  description = "To enable master user password or not"
  type        = bool
  default     = false
}

variable "db_password" {
  description = "Password for RDS"
  type        = string
}

variable "db_instance_class" {
  description = "The RDS instance class"
  type        = string
}

variable "set_db_password" {
  description = "Condition to check for custom password"
  type        = string
}

variable "db_storage_size" {
  description = "The allocated storage size for the RDS instance."
  type        = number
}

variable "backup_retention_period" {
  description = "The number of days to retain automated backups."
  type        = number
}

variable "multi_az" {
  description = "Enable multi-AZ deployment for the RDS instance."
  type        = bool
}

variable "delete_automated_backups" {
  description = "Enable deletion of automated backups when the RDS instance is deleted."
  type        = bool
}

variable "copy_tags_to_snapshot" {
  description = "Copy tags to DB snapshots created from the RDS instance."
  type        = bool
}

variable "publicly_accessible" {
  description = "Allow the RDS instance to be publicly accessible."
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Skip the creation of a final DB snapshot when the RDS instance is deleted."
  type        = bool
}

variable "apply_immediately" {
  description = "Apply changes immediately to the RDS instance."
  type        = bool
}

variable "db_engine" {
  description = "The database engine"
  type        = string
}

variable "db_storage_type" {
  description = "The storage type for the database"
  type        = string
}

variable "ingress_from_port" {
  description = "The starting port for ingress rules"
  type        = number
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDR block for RDS security group"
}

variable "ingress_to_port" {
  description = "The ending port for ingress rules"
  type        = number
}

variable "ingress_protocol" {
  description = "The protocol for ingress rules"
  type        = string
}

variable "egress_from_port" {
  description = "The starting port for ingress rules"
  type        = number
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "CIDR block for RDS security group"
}

variable "egress_to_port" {
  description = "The ending port for egress rules"
  type        = number
}

variable "egress_protocol" {
  description = "The protocol for egress rules"
  type        = string
}


variable "subnet_ids" {
  description = "The IDs of the subnets"
  type        = list(string)
}

variable "vpc_id" {
  description = "Vpc ID in which it needs to create"
  type        = string
}

variable "parameter_store_secret_name" {
  description = "Name of the parameter store secret"
  type        = string
}

variable "type" {
  description = "Parameter store type"
  type        = string
}