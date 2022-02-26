# Packer Templates for Proxmox

**Requires Packer 1.7.4+ with Proxmox 6.2-15**

```ps1
cd alpine-3.14.3-amd64
packer build -var-file="main-vars.pkr.hcl" -var template_name=alpine -var proxmox_host=proxmox:443 -var proxmox_api_user=root@pam -var proxmox_api_password="" -var iso_download=false -var proxmox_node_name=pve -var vmid=1234 -only="linux.* ../
```

For windows `packer build -only="windows.*"`