provider "aws" {
  region = "us-west-2"
}

module "ec2_instance" {
  source = "../modules/ec2"
  instance_name      = "jenkins-agent"
  ami_id             = "ami-0fe5ed92a8c77d79f"
  instance_type      = "t2.small"
  key_name           = "techiescamp"
  subnet_ids         = ["subnet-046c3f4390fc51b7e", "subnet-02727435b393c516c", "subnet-0ed1c80066f1be7ed"]
  instance_count     = 1
}
