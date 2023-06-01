provider "aws" {
  region = "us-west-2"
}

module "lb-asg" {
  source        = "../modules/lb-asg"
  subnets       = ["subnet-981546e1", "subnet-95bfc2de", "subnet-07290b5d"]
  ami_id        = "ami-02ffebe707422b1ac"
  instance_type = "t2.small"
  key_name      = "jenkins-dos"
  environment   = "dev"
  vpc_id        = "vpc-e0fb3d98"
}