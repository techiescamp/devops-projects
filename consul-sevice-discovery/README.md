## Provision Instances Using Terraform

Initialize terraform

```
terraform init
```

Provision the instances using the following command.

```
terraform apply
```
## Get all the IP addresses

## Configure Instances Using Ansible

Configure Consul Server

```
ansible-playbook consul-server.yaml
```

Configure Backends. Replace 172.31.26.233 with private IP of the consul server.

```
ansible-playbook -e "start_join=172.31.26.233" backends.yaml
```

Configure Load Balancer. Replace 172.31.26.233 with private IP of the consul server.

```
ansible-playbook -e "consul_server_address=172.31.31.142:8500" load-balancer.yaml 
```

## Tear Down the Servers

cd in to terraform directory and run the following command

```
terraform destroy
```

