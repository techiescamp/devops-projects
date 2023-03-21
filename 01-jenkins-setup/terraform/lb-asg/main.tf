provider "aws" {
  region = "us-west-2"
}

module "lb-asg" {
  source = "../modules/lb-asg"
  subnets = ["subnet-058a7514ba8adbb07", "subnet-0dbcd1ac168414927", "subnet-032f5077729435858"]
  ami_id = "ami-0f7cbb73797d9f23d"
  instance_type ="t2.small"
  key_name = "techiescamp"
  environment = "dev"
  vpc_id = "vpc-0a5ca4a92c2e10163"
}