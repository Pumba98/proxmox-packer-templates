# Packer Templates for Proxmox

**Requires Packer 1.7.4+ with Proxmox 6.2-15**

Build VM Templates with Packer for Proxmox. The generated templates are meant to be used with cloud-init, they come without a User or root login.  
Only the Windows Server Template has a Administrator user by default (Password `packer`). It's ready for Ansible setup via winrm.

**All templates are made for my personal environment and may need adjustments for yours!**

## Overview

| OS                                                   | Status                                                                                                                                                                                                                           |
| ---------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Ubnuntu 20.04](./ubuntu-20.04.pkr.hcl)              | [![ubuntu-20.04](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-20.04.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-20.04.yml)                      |
| [Ubnuntu 18.04](./ubuntu-18.04.pkr.hcl)              | [![ubuntu-18.04](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-18.04.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-18.04.yml)                      |
| [Debian 11](./debian-11.pkr.hcl)                     | [![debian-11](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-11.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-11.yml)                               |
| [Debian 10](./debian-10.pkr.hcl)                     | [![debian-10](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-10.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-10.yml)                               |
| [Alpine 3.15](./alpine.pkr.hcl)                      | [![alpine](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine.yml)                                        |
| [Windows Server 2019](./windows-server-2019.pkr.hcl) | [![windows-server-2019](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2019.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2019.yml) |

## How to build

### Prepare Packer

First initialize the proxmox packer plugin:

```sh
packer init config.pkr.hcl
```

### Prepare your variables

The templates all use a generic source builder ([generic.pkr.hcl](./generic.pkr.hcl)) that's driven by variables. The OS specific settings are only variables and preseed files.

To build packer templates you need to set some variables via file (`-var-file=my.pkrvars.hcl`), cli (`-var variablename=value`), or environment (`PKR_VAR_variablename=value`):
- proxmox_host
- proxmox_user
- proxmox_password
- node
- vmid

Other interesting variables are:
- pool
- proxmox_insecure_tls
- disk_storage_pool
- disk_storage_pool_type
- iso_storage_pool
- cloud_init_storage_pool
- iso_download

See [variables.pkr.hcl](./variables.pkr.hcl) for all varaibles.

### Build a template

To build a template (e.g. `debian-11`) run:

```sh
packer build -var-file="debian-11.pkrvars.hcl" -only="linux.*" .
```

For windows:

```sh
packer build -var-file="windows-server-2019.pkrvars.hcl" -only="windows.*" .
```

The Windows template requires a `win-server-2019_x64FRE_en-us.iso` and [virtio-win-0.1.185.iso](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/virtio-win-0.1.185.iso) in your iso storage.
