provider "aws" {
  region = "us-west-2"
}

module "ec2_instance" {
  source = "../modules/ec2"

  instance_name      = "jenkins-agent"
  ami_id             = "ami-047fe714e6e0ac977"
  instance_type      = "t2.small"
  key_name           = "techiescamp"
  subnet_ids         = ["subnet-058a7514ba8adbb07", "subnet-0dbcd1ac168414927", "subnet-032f5077729435858"]
  instance_count     = 1
}
