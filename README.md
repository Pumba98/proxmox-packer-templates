[![Build Status](https://drone.pumba98.de/api/badges/Pumba98/proxmox-packer-templates/status.svg)](https://drone.pumba98.de/Pumba98/proxmox-packer-templates)

**Requires Packer 1.7.4+ with Proxmox 6.2-15**

## Linux

> cd ubuntu/debian-xxx
> packer build -var-file=../proxmox.json packer.json`

## Windows

Drivers: `https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/virtio-win-0.1.185.iso`

> mkisofs -J -l -R -V "Label CD" -iso-level 4 -o Autounattend.iso setup