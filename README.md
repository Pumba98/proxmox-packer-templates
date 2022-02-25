[![Build Status](https://drone.pumba98.de/api/badges/Pumba98/proxmox-packer-templates/status.svg)](https://drone.pumba98.de/Pumba98/proxmox-packer-templates)

**Requires Packer 1.7.4+ with Proxmox 6.2-15**

## Linux

> cd ubuntu/debian-xxx
> packer build -var-file=../proxmox.json packer.json`

```ps1
cd alpine-3.14.3-amd64
..\packer.exe build -var-file="main-vars.pkr.hcl" -var template_name=alpine -var proxmox_host=proxmox:443 -var proxmox_api_user=root@pam -var proxmox_api_password="" -var iso_download=false -var proxmox_node_name=nuc8i5beh -var vmid=1234 -var iso_download=true ..\generic.pkr.hcl
```

## Windows

Drivers: `https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/virtio-win-0.1.185.iso`

> mkisofs -J -l -R -V "Label CD" -iso-level 4 -o Autounattend.iso setup