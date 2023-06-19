# Getting a super safe SSH on Linux with Vault

Content based on a Live session from LINUXTips: [Como ter um SSH Super seguro com LINUX + Vault](https://www.youtube.com/watch?v=QIEH3DXXkFU)


gerar chave ssh
hostname vault-server
echo vault-server > /etc/hostname
bash

```bash
# history vault
sudo su -
wget https://releases.hashicorp.com/vault/1.13.3/vault_1.13.3_linux_amd64.zip
apt update -y && apt install -y unzip net-tools
ls
wget https://releases.hashicorp.com/vault/1.13.3/vault_1.13.3_linux_amd64.zip
apt update -y && apt install unzip -y
history
unzip vault_1.13.3_linux_amd64.zip 
mv vault /usr/local/bin/
vault
vault server -dev -dev-listen-address=0.0.0.0:8200  -dev-root-token-id=giropops &
netstat -atunp
apt install net-tools
netstat -atunp
tcp        0      0 0.0.0.0:8200            0.0.0.0:*               LISTEN      1968/vault        
tcp        0      0 0.0.0.0:8200            0.0.0.0:*               LISTEN      1968/vault          
vault secrets enable ssh
export VAULT_ADDR="http://127.0.0.1:8200"
vault secrets enable ssh
vault status
vault write ssh/roles/otp_key_role key_type=otp default_user=ubuntu cidr_list=0.0.0.0/0
vim policy.hcl
vault write ssh/roles/otp_key_role key_type=otp default_user=ubuntu cidr_list=0.0.0.0/0
vim policy.hcl
vault policy write test ./policy.hcl 
vault auth enable userpass
vault list userpass/
vault list secrets/
vault list ssh/roles
vault read  ssh/roles/otp_key_roles
vault read  ssh/roles/otp_key_role
vault auth --help
vaul auth list
vault auth list
vault write auth/userpass/users/giropops password="girus" policies="test"
history


#history linux
echo ssh-alvo > /etc/hostname
wget https://releases.hashicorp.com/vault-ssh-helper/0.2.1/vault-ssh-helper_0.2.1_linux_amd64.zip
apt update -y && apt install -y unzip net-tools
unzip -q vault-ssh-helper_0.2.1_linux_amd64.zip -d /usr/local/bin
chmod 0755 /usr/local/bin/vault-ssh-helper
chown root:root /usr/local/bin/vault-ssh-helper
mkdir /etc/vault-ssh-helper.d/
vim /etc/vault-ssh-helper.d/config.hcl
vim /etc/pam.d/sshd 
vim /etc/ssh/sshd_config
systemctl restart sshd
vault
vault-ssh-helper -verify-only
vault-ssh-helper -verify-only -dev -config /etc/vault-ssh-helper.d/config.hcl 
vim /etc/vault-ssh-helper.d/config.hcl
cat /etc/vault-ssh-helper.d/config.hcl
#unzip -q vault-ssh-helper_0.2.1_linux_amd64.zip -d /usr/local/bin
tail -f /var/log/vault-ssh.log 
vim /etc/vault-ssh-helper.d/config.hcl
tail -f /var/log/vault-ssh.log 
vault-ssh-helper -verify-only -dev -config /etc/vault-ssh-helper.d/config.hcl 
echo $VAULT_ADDR
vim /etc/vault-ssh-helper.d/config.hcl
vault-ssh-helper -verify-only -dev -config /etc/vault-ssh-helper.d/config.hcl 
vim /etc/vault-ssh-helper.d/config.hcl
vault-ssh-helper -verify-only -dev -config /etc/vault-ssh-helper.d/config.hcl 
systemctl restart sshd
vim /etc/ssh/sshd_config
vim /etc/pam.d/sshd 
vault-ssh-helper -verify-only -dev -config /etc/vault-ssh-helper.d/config.hcl 
tail -f /var/log/vault-ssh.log 
history local
export VAULT_ADDR="http://54.185.241.37:8200"
vault status
wget https://releases.hashicorp.com/vault/1.13.3/vault_1.13.3_linux_amd64.zip
apt update -y && apt install -y unzip net-tools
sudo apt update -y && apt install -y unzip net-tools
unzip -q vault_1.13.3_linux_amd64.zip -d /usr/local/bin
sudo unzip -q vault_1.13.3_linux_amd64.zip -d /usr/local/bin
vault status
vault list ssh/roles
vault list secrets
vault login -method=userpass username=giropops password=girus
vault write ssh/creds/otp_key_role ip=50.112.20.224
ssh ubuntu@50.112.20.224
vault write ssh/creds/otp_key_role ip=50.112.20.224
ssh ubuntu@50.112.20.224
vault write ssh/creds/otp_key_role ip=50.112.20.224
```

Unseal Key: < unseal key >
Root Token: giropops < or any name >

## Policies

```hcl
# To view in Web UI
path "sys/mounts" {
  capabilities = [ "read", "update" ]
}

# To enable secrets engines
path "sys/mounts/*" {
  capabilities = [ "create", "read", "update", "delete" ]
}

# To configure the SSH secrets engine
path "ssh/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}
```

## vim policy.hcl

```hcl
path "ssh/creds/otp_key_role" {}
  capabilities = [ "create",  "read", "update"]
}
```

## /etc/vault-ssh-helper.d/config.hcl

```hcl
vault_addr = "172.31.18.174"
tls_skip_verify = false
ssh_mount_point = "ssh"
allowed_roles = "*"
allowed_cidr_list = < target IP >
```

## sudo vim /etc/pam.d/sshd

```text
auth requisite pam_exec.so quiet expose_authtok log=/var/log/vault-ssh.log /usr/local/bin/vault-ssh-helper -dev -config=/etc/vault-ssh-helper.d/config.hcl
auth optional pam_unix.so not_set_pass use_first_pass nodelay
```

## sudo vim /etc/ssh/sshd_config

```text
KbdInteractiveAuthentication yes
UsePAM yes
PasswordAuthentication no
```
