# Packer Templates for Proxmox

**Requires Packer 1.7.4+ with Proxmox 6.2-15**

Build VM Templates with Packer for Proxmox. The generated templates are meant to be used with cloud-init, they come without a User or root login.  
Only the Windows Server Template has a Administrator user by default (Password `packer`). It's ready for Ansible setup via winrm.

**All templates are made for my personal environment and may need adjustments for yours!**

## Overview

| OS                  | Status                                                                                                                                                                                                                           |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Ubnuntu 20.04       | [![Ubuntu-20.04](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-20.04.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-20.04.yml)                      |
| Ubnuntu 18.04       | [![Ubuntu-18.04](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-18.04.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-18.04.yml)                      |
| Debian 11           | [![Debian-11](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-11.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-11.yml)                               |
| Debian 10           | [![Debian-10](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-10.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-10.yml)                               |
| Alpine 3.14         | [![Alpine-3.14](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine-3.14.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine-3.14.yml)                         |
| Windows Server 2019 | [![Windows-Server-2019](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2019.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2019.yml) |

## How to build

The templates all use a generic source builder ([generic.pkr.hcl](./generic.pkr.hcl)) that's driven by variables. The OS specific settings are only variables and preseed files.

You need to set some variables via file (`-var-file=myvars.pkr.hcl`), cli (`-var variablename=value`), or environment (`PKR_VAR_variablename=value`):
- proxmox_host
- proxmox_api_user
- proxmox_api_password
- proxmox_node_name
- vmid

From **inside** a template directory (e.g. `debian-11-amd64`) run:

```sh
packer build -var-file="main-vars.pkr.hcl" -only="linux.* ../
```

For windows:
```sh
packer build -var-file="main-vars.pkr.hcl" -only="windows.*" ../
```

Other interesting variables:
- proxmox_pool
- proxmox_insecure_tls
- datastore
- datastore_type
- iso_storage_pool
- cloud_init_storage_pool
- iso_download

See [variables.pkr.hcl](./variables.pkr.hcl) for all varaibles.
