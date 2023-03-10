provider "aws" {
  region = "us-west-2"
}

module "rds" {
  source = "../modules/rds"
}