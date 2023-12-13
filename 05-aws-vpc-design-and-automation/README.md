# Design a AWS VPC For Application and Automate VPC Creation Using Terraform

Lets first understand how VPCs are managed in organizations.

In large organizations, the network is managed by a dedicated network team.

However, it's crucial for DevOps engineers to understand AWS network concepts to collaborate more effectively with network teams. 

It specicailly helps during troubleshooting. 

For example, 

There is a big difference when you say “It’s not working, can you look into this” and “Hey, I have done my initial network troubleshooting, and here are my findings. Can you look into this further and help us understand what’s causing the issue”

In small to medium-sized organizations or startups, network management is typically handled by DevOps engineers or developers.

## Design a VPC

In the design section, you'll learn how to create an AWS VPC for the following application architecture.

![image](https://github.com/techiescamp/devops-projects/assets/106984297/5b855e54-1980-4a00-b2e7-44b689a986cd)

The architecture includes the following application categories:

- Web Application (Java App)
- Automation Tools (App/Infra CI/CD)
- Platform Tools (e.g., Prometheus, Grafana)
- Managed Services (e.g., RDS Database, S3, Secrets Manager)
- Additionally, you will document the necessary VPC CIDR, subnets, etc. This is a standard practice in organizations

**Design Documentation:** [AWS VPC Design: A Practical Approach](https://devopscube.com/aws-vpc-design/)

## Automate VPC Creation Using Terraform

Once you grasp VPC design and documentation, the next step is to automate VPC management, enabling reproducibility and simplified management with a single click.

We will be creating the VPC with the following

- **CIDR Block:** 10.0.0.0/16
- **Region**: us-west-2
- **Availability Zones:** us-west-2a, us-west-2b, us-west-2c
- **Subnets**: 15 Subnets (One per availability Zone)
   - Public Sunets (3)
   - App Subets (3)
   - DB Subnets (3)
   - Management Subnets (3)
   - Platform Subnet (3)
- **NAT Gateway** for Private subnets
- **Internet Gateway** for public subnets.
- **Enabled Endpoints:** s3, Cloudwatch & Secrets Manager
- **Dedicated NACLs** for 4 set of subnets.

We have created Terraform VPC modules for the requirements we outlined in the Design.

**Terraform VPC Creation Documentation:** [Create AWS VPC Using Terraform](https://devopscube.com/terraform-aws-vpc/)

## Further Learning References

1. [One to Many: Evolving VPC Design](https://aws.amazon.com/blogs/architecture/one-to-many-evolving-vpc-design/)
2. [AWS Network Connectivity Models](https://docs.aws.amazon.com/whitepapers/latest/hybrid-connectivity/connectivity-models.html)
3. [AWS Hybrid Network Design Pattern](https://aws.amazon.com/blogs/apn/vmware-cloud-on-aws-hybrid-network-design-patterns/)








