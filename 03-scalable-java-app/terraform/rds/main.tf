provider "aws" {
  region = "us-west-2"
}

module "rds" {
  source = "../modules/rds"
  secret_name ="/dev/petclinic/db"
  db_username = "petclinic"
  db_name = "petclinic-mysql-rds"
  db_instance_class = "db.t2.micro"
  parameter_name = "/dev/petclinic/rds_endpoint"
}