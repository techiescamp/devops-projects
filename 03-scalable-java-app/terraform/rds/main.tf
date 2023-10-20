provider "aws" {
  region = "us-west-2"
}

module "rds" {
  source                   = "../modules/rds"
  region                   = "us-west-2"
  secret_name              = "/dev/petclinic/db"
  password_length          = 8
  special_characters       = true
  override_special         = "_@%"
  db_username              = "petclinic"
  ingress_from_port        = 3306
  ingress_to_port          = 3306
  ingress_protocol         = "tcp"
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  egress_from_port         = 0
  egress_to_port           = 0
  egress_protocol          = "-1"
  egress_cidr_blocks       = ["0.0.0.0/0"]
  db_engine                = "mysql"
  db_instance_class        = "db.t2.micro"
  db_storage               = 10
  db_storage_type          = "gp2"
  db_subnet_group          = "default"
  backup_retention_period  = 7
  delete_automated_backups = true
  copy_tags_to_snapshot    = true
  publicly_accessible      = true
  skip_final_snapshot      = true
  apply_immediately        = true
  parameter_name           = "/dev/petclinic/rds_endpoint"
  parameter_type           = "String"
  owner                    = "techiescamp"
  environment              = "dev"
  cost_center              = "techiescamp-commerce"
  application              = "pet-clinic"
}