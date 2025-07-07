provider "aws" {
  region = "us-west-2"
}

module "lb-asg" {
  source        = "../modules/lb-asg"
  subnets       = ["subnet-046c3f4390fc51b7e", "subnet-02727435b393c516c", "subnet-0ed1c80066f1be7ed"]
  ami_id        = "ami-0e9419006a1fc1387"
  instance_type = "t2.small"
  key_name      = "techiescamp"
  environment   = "dev"
  vpc_id        = "vpc-0872a2ffd55e763ca"
}