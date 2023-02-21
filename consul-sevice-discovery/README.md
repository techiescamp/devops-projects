## Project Architecture

![service-discovery](https://user-images.githubusercontent.com/106984297/219394737-6f41c9f3-6c34-420b-9da2-9cc819f9c076.png)

## Manual Setup

 If you want to practically learn service discovery, I suggest you set up Nginx load balancing using consul service discovery setup manually and learn all the components and workflows involved in it.
 
 **Checkout the Prctical Guide:** [Service Discovery Example Using Consul & Nginx](https://devopscube.com/service-discovery-example/) 

## Automation Prerequisites

- You need to have a valid AWS account
- A workstation or AWS instance configured with AWS CLI, Ansbile and Terrform with full access to provision ec2 instances.


## Provision Instances Using Terraform

### Prepare the variable file

Repalce the parameters in the terraform.tfvars. 

Primarily you need to replace the key name `techiescamp` to the pem key you have in your AWS account.
Other parameters are common or AWS oregon region with default VPC. If you are using a different region and VPC, replace it accordingly.

```
instance_type      =   "t2.micro"
region             =   "us-west-2"
ami                =   "ami-0735c191cf914754d"
key_name           =   "techiescamp"
ingress_cidr_block =   "172.31.0.0/16"
```

### Initialize terraform

```
terraform init
```
### Dry Run Terraform

Perform "dry run" of the terraform apply to check what changes will be made to your infrastructure when you apply your configuration.

```
terraform plan -var-file=terraform.tfvars

```

### Provision Instances

Provision the instances by applying the configuration.
```
terraform apply -var-file=terraform.tfvars -auto-approve 
```

## Configure Instances Using Ansible

### Create a inventory file to configure the instances

Get all the IP addresses.

```
aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=consul-server,loadbalancer,backend-app" \
    --query 'Reservations[].Instances[].[PrivateIpAddress,PublicIpAddress,Tags[?Key==`Name`].Value[]]' \
    --output text 
```

Modify the Ansible Inventory file as shown below. Repalce the IPs and pem key file location as per your Anisble configurations.

```
[consul]
54.188.111.53

[load-balancer]
35.87.82.33

[backends]
35.92.38.123
35.87.82.33

[all:vars]
ansible_user=ubuntu
ansible_private_key_file=/home/vagrant/.ssh/techiescamp.pem
```

Cd in to ansible directory.

### Configure Consul Server

```
ansible-playbook consul-server.yaml
```


### Configure Backends. 

Get the Consul server Private IP address and save it in the PRIVATE_IP variable.

```
PRIVATE_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=consul-server" --query "Reservations[].Instances[].PrivateIpAddress" --output text)
```

Exeute the backend playbook

```
ansible-playbook -e "consul_server_address=$PRIVATE_IP" backends.yaml
```
### Configure Load Balancer. 

Get the Consul server Private IP address and save it in the PRIVATE_IP variable.

```
PRIVATE_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=consul-server" --query "Reservations[].Instances[].PrivateIpAddress" --output text)
```
Execute the load-balancer playbook

```
ansible-playbook -e "consul_server_address=$PRIVATE_IP:8500" load-balancer.yaml 
```


## validate the Setup

If you visit the Loadblancer Ip you should be able to get the custom HTML page with backend server information.

## Tear Down the Servers

cd in to terraform directory and run the following command

```
terraform destroy
```

