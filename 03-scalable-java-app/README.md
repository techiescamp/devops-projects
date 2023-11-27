
## Scalable Java Application on AWS Using Terraform

![java-aws](https://user-images.githubusercontent.com/106984297/219648306-42c0d544-f6e6-423d-9802-9f3d5eca43e8.png)

## Project Documentation & Walkthrough

Refer the following document for the step by step project walkthrough.

**Project Documentation:** [Deploy Scalable Java Applications on AWS Using Terraform](https://devopscube.com/deploy-java-applications-aws-autoscaling/)

## Java Application

For this project you can use the open source pet clinic application (Java Spring Boot)

```
https://github.com/spring-projects/spring-petclinic
```

## Tools/Services 

- DevOps Tools
  - Jenkins
  - Packer
  - Ansible
  - Terraform

- AWS Services
  - Application Load Balancer (L7)
  - Autoscaling Group
  - AWS secrets manager
  - RDS (MySQL)

## Project Workflow

- Build Java application
- Use Packer & Ansible to build the AMI With application code
    - configure application logging
    - configure cloudwatch agent with the application log location.
- Use Teraaform to provision the following 
    - MySQL RDS instance and store the username and password in AWS secrets manager
    - Provision Application Load Blancer 
    - Create a launch template With the Application AMI
    - Provision Autoscaling Group with Launch tempalate that use AMI built by packer and attach it to Loadbalancer.
- Verify application by accessing it using Load Balancer endpoint.
- Verify application logs in Cloudwatch

## Other Useful Resources

1. [RDS password Rotation With Terraform](https://advancedweb.hu/how-to-set-up-amazon-rds-password-rotation-with-terraform/)
