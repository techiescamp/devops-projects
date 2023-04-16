
## Status [In Progress]

This project IaC code testing is in progress

## Project Architecture

![java-aws](https://user-images.githubusercontent.com/106984297/219648306-42c0d544-f6e6-423d-9802-9f3d5eca43e8.png)


# Java Application

For this project you can use the open source pet clinic application (Java Spring Boot)

```
https://github.com/spring-projects/spring-petclinic
```

# Tools/Services 

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

# Project Workflow

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

## Java Application 

Spring boot Petclinic application

```
git clone https://github.com/techiescamp/java-spring-petclinic
```

Starting the application with externalized properties file.

```
java -jar spring-petclinic.jar --spring.config.location=/path/to/application.properties --spring.profiles.active=mysql
```

Log Location

```
/opt/petclinic.log
```

Change folder persmissions

```
sudo chown -R petclinic:petclinic /opt
sudo chmod -R u+w /opt
```

## Useful Resources

1. [RDS password Rotation With Terraform](https://advancedweb.hu/how-to-set-up-amazon-rds-password-rotation-with-terraform/)


