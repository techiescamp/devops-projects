# Original project

## Setup Architecture 

![jenkins-ha](https://user-images.githubusercontent.com/106984297/226690774-66731923-a2cd-45cc-b387-c959e5b713c1.png)


## Project Documentation.

Refer [Jenkins Setup Using AWS Autoscaling Group](https://devopscube.com/jenkins-autoscaling-setup/) for the entire setup walkthrough.

# My deployment

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install packer
```

```bash
packer build -var "efs_mount_point=fs-0683b367a43270a68.efs.us-west-2.amazonaws.com" jenkins-controller.pkr.hcl
```

Jenkins Controller AMI were created:
us-west-2: ami-02ffebe707422b1ac

Jenkins Agent AMI were created:
us-west-2: ami-0aa67fbeed5057f64

Instance Configuration
Jenkins URL: http://jenkins-alb-561924746.us-west-2.elb.amazonaws.com/

To deregister the AMIs, use the following AWS CLI commands

```bash
aws ec2 describe-images --filters "Name=name,Values=jenkins-controller,jenkins-agent" --query 'Images[*].ImageId' --output text | tr '\t' '\n' | xargs -I {} aws ec2 deregister-image --image-id {}
```