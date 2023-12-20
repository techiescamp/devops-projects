# terraform-aws
Terraform AWS EC2 provisioning 

## Hit the Star! ⭐
If you are planning to use this Terraform repo for learning, please hit the star. Thanks!

## EC2 Instance Provisioning

1. Navigate to the `environment/dev/ec2` folder:

```bash
cd prometheus-stack/
```

2. Open the `ec2.tfvars` file and modify it with your desired details. This file contains variables used in the Terraform configuration.

### Deployment

1. Format Terraform code per HCL canonical standards in the working directory:

```bash
terraform fmt
```

2. Validate Terraform code in the working directory:

```bash
terraform validate
```

3. Initialize Terraform in the working directory:

```bash
terraform init
```

4. Create an execution plan:

```bash
terraform plan --var-file=../vars/ec2.tfvars
```

5. Apply the changes to create the EC2 instance:

```bash
terraform apply --var-file=../vars/ec2.tfvars
```

6. To destroy the EC2 instance and associated resources:

```bash
terraform destroy --var-file=../vars/ec2.tfvars
```

**Note**: Always review the execution plan (`terraform plan`) before applying changes to avoid unintended modifications.


## Terraform Command Reference

Update all outputs:

<pre>terraform refresh</pre>

Show all outputs:

<pre>terraform show</pre>



