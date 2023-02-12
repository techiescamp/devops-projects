## Provision Instances Using Terraform

Initialize terraform

```
terraform init
```

Provision the instances using the following command.

```
terraform apply
```
## Configure Instances Using Ansible

Configure Backends

```
ansible-playbook -e "start_join=172.31.26.233" backends.yaml
```

Configure Load Balancer

```
ansible-playbook -e "consul_server_address=172.31.31.142:8500" load-balancer.yaml 
```

