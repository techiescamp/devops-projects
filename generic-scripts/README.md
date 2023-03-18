
## Ansible Commands

```
ansible-playbook playbook.yml"
```

## Terraform Commands

```
terraform plan -var="reinstance_name=aswin-test-vm" -var="instance_type=t2.micro"

terraform apply -var="reinstance_name=aswin-test-vm" -var="instance_type=t2.micro" --auto-approve

terraform destroy -var="reinstance_name=aswin-test-vm" -var="instance_type=t2.micro" --auto-approve

```