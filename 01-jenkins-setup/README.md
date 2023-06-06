# Jenkins Setup Using AWS Autoscaling Group, Load Balancer & EFS

## My deployment/experience

The main idea here is to document/describe my experience while learning/practicing with the suggested projects.

### Initial impressions

In my scenario it was used WSL2 as workspace and that is importante because: 
  1. WSL2 system can desyncronize from the Windows _Date and Time_ system, which can lead to certificates errors
    - This is a know issue and have some workarounds
  1. Installing linux packages can be different, I'm preferring to use links with specific versions over default methods for latest versions. If you're not using a standard environment, is only logical that you may have to deal with non-standard approaches

### Deployment 

Ok, let's go!

Prerequisite ok, everything installed and setup, let's test the AWS CLI and... First error: The certificate is out of sync (wsl2)
  - Ok, searched how to solve it, understood that this is not a common/real world kind of problem, documented it at my personal `initial setup` repository and moved on

Created the _IAM role_, the _EFS storage_ and then it was time to use _Packer_ for the first time, to create the Jenkins controller _AMI_, and... I got stuck in this step for around 3h.

The execution was supposed to be real simple:
>Replace the DNS in the following command with your EFS DNS endpoint:
> - packer build -var "efs_mount_point=< EFS DNS endpoint >" jenkins-controller.pkr.hcl
>
>Upon successful execution, you will see the registered Jenkins-controller AMI ID in the output.

But it was not!

Because of unknown reasons, the Ansible installation with the default command from the official website, installed a version that older than the latest. This outdated version was giving error with the Packer `extra_arguments` argument, while executing the installation. After some searching, discovered a commom error  with the older version, confirmed that I had the outdated version, ran the installation again, new version installed and YES!, passed the first step...

... Got stuck right away because of the `"--scp-extra-args", "-O",` argument ([here](https://github.com/denisolivares/devops-projects/blob/main/01-jenkins-setup/jenkins-controller.pkr.hcl#L35)).

It was a funny journey to
  - Search and learn how the arguments are declared/coupled in an Ansible file
  - Search the SCP manual to learn the possible arguments and its functionalities
  - Try the possible arguments

And finally figure out that maybe the argument was duplicated and probably could be removed (after all, after so much searching, I had learned something).

Done! That really did the trick. Moved forward and was able to deploy the whole stack

### Teardown

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install packer
```

```bash
packer build -var "efs_mount_point=fs-0683b367a43270a68.efs.us-west-2.amazonaws.com" jenkins-controller.pkr.hcl
```

Jenkins Controller AMI were created:
us-west-2: < ami-id > 

Jenkins Agent AMI were created:
us-west-2: < ami-id >

Instance Configuration
Jenkins URL: < jennkins URL >

To deregister the AMIs, use the following AWS CLI commands

```bash
aws ec2 describe-images --filters "Name=name,Values=jenkins-controller,jenkins-agent" --query 'Images[*].ImageId' --output text | tr '\t' '\n' | xargs -I {} aws ec2 deregister-image --image-id {}
```

To delete the parameter store values, use the following command.

```bash
aws ssm delete-parameter --name /devops-tools/jenkins/id_rsa
aws ssm delete-parameter --name /devops-tools/jenkins/id_rsa.pub
```


## Original project

### Setup Architecture 

![jenkins-ha](https://user-images.githubusercontent.com/106984297/226690774-66731923-a2cd-45cc-b387-c959e5b713c1.png)

### Project Documentation.

Refer [Jenkins Setup Using AWS Autoscaling Group](https://devopscube.com/jenkins-autoscaling-setup/) for the entire setup walkthrough.
