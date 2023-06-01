provider "aws" {
  region = "us-west-2"
}

module "efs_module" {
  source = "../modules/efs"
  vpc_id     = "vpc-e0fb3d98"
  subnet_ids = ["subnet-981546e1", "subnet-95bfc2de", "subnet-07290b5d"]
}