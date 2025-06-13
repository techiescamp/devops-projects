provider "aws" {
  region = "us-west-2"
}

module "efs_module" {
  source = "../modules/efs"
  vpc_id     = "vpc-0872a2ffd55e763ca"
  subnet_ids = ["subnet-046c3f4390fc51b7e", "subnet-02727435b393c516c", "subnet-0ed1c80066f1be7ed"]
}