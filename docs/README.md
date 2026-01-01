# Documentation

This folder contains useful hints on how to provision a VM with the packer templates

## OPNSense

### Setup VM

```bash
cp secrets.template.yml secrets.yml

sudo apt install ansible
ansible-galaxy collection install community.proxmox

ansible-playbook create-opnsense-vm-playbook.yml -e @./secrets.yml
```

### Create API keys

With Ansible

```bash
cp secrets.template.yml secrets.yml

sudo apt install ansible
ansible-galaxy collection install community.proxmox

# investigate the modes in the playbook:

#opnsense_api_force: false
#opnsense_api_delete_existing: false

ansible-playbook create-opnsense-api-keys-playbook.yml -e @./secrets.yml

# store the keys in secrets.xml
```

Bash script

```bash
export OPNSENSE_HOST=https://10.10.1.1 # ip of the opnsense vm
export OPNSENSE_PASSWORD=Secret123
./create-opnsense-api-keys.sh -h
./create-opnsense-api-keys.sh --delete-existing | jq .
{
  "result": "ok",
  "hostname": "OPNsense.internal",
  "key": "iDmG3jCVitsb7jySqxMeDSkkNk5o3Cjo9PwfwlLxttmUjGEZFJpbv70xj3UefXo4zeoHZqa5YYymyqv9",
  "secret": "mB64f2oCAjuu8AdK0t5SXgkIr5XJq5vKGKLibLDeKIrxFElAc2KIjjvfFZmQ5C2L1kF3ov7L1i8APMIj"
}

# store the keys in secrets.xml
```

Setup OPNsense

```bash
# https://ansible-opnsense.oxl.app/usage/1_install.html
ansible-galaxy collection install oxlorg.opnsense
sudo apt-get install python3-httpx
# https://ansible-opnsense.oxl.app/
ansible-playbook  opnsense-playbook.yml -e @./secrets.yml
```

### Your Job / Next Steps

- Use opnsense.oxl to secure the firewall
- The template turned off the firewall (!)
- e.g. create rules for ssh/http if needed
- e.g. add ACME certificates for https
