provider "aws" {
  region = "us-west-2"
}

module "efs_module" {
  source = "../modules/efs"
  vpc_id     = "vpc-0a5ca4a92c2e10163"
  subnet_ids = ["subnet-058a7514ba8adbb07", "subnet-0dbcd1ac168414927", "subnet-032f5077729435858"]
}