
```
cp terraform.tfvars.sample terraform.tfvars
```

Configure your aws environment in `terraform.tfvars`.

```
terraform init terraform
terraform plan -out plan terraform
terraform apply plan
```


```
./deploy-jumpbox.sh
```

```
cat <<EOF > ssh-jumpbox.sh
bosh int jumpbox-creds.yml --path /jumpbox_ssh/private_key > jumpbox.pem
chmod 600 jumpbox.pem

ssh -o "StrictHostKeyChecking=no" jumpbox@$(terraform output --json | jq -r '.external_ip.value') -i $(pwd)/jumpbox.pem
EOF
chmod +x ssh-jumpbox.sh
```


```
terraform destroy -force terraform
```