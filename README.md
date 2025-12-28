# Packer Templates for Proxmox

**Tested with with Proxmox 9.1.2, Packer 1.14 and Packer Proxmox Plugin v1.2.3**

Build VM Templates with Packer for Proxmox. The generated templates are meant to be used with cloud-init, they come without a User or root login.
Only the Windows Server Template has a Administrator user by default (Password `packer`). It's ready for Ansible setup via winrm.

**All templates are made for my personal environment and may need adjustments for yours!**

## Overview

| OS                                                       | Status                                                                                                                                                                                                                           | Username / Password                                                   |
| -------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| [Ubnuntu 24.04](./ubuntu-24.04.pkrvars.hcl)              | [![ubuntu-24.04](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-24.04.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-24.04.yml)                      | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Ubnuntu 22.04](./ubuntu-22.04.pkrvars.hcl)              | [![ubuntu-22.04](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-22.04.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-22.04.yml)                      | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Ubnuntu 20.04](./ubuntu-20.04.pkrvars.hcl)              | [![ubuntu-20.04](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-20.04.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-20.04.yml)                      | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Ubnuntu 18.04](./ubuntu-18.04.pkrvars.hcl)              | [![ubuntu-18.04](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-18.04.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/ubuntu-18.04.yml)                      | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Debian 13](./debian-13.pkrvars.hcl)                     | [![debian-13](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-13.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-13.yml)                               | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Debian 12](./debian-12.pkrvars.hcl)                     | [![debian-12](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-12.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-12.yml)                               | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Debian 11](./debian-11.pkrvars.hcl)                     | [![debian-11](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-11.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/debian-11.yml)                               | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [AlmaLinux 10](./almalinux-10.pkrvars.hcl)               | [![almalinux-10](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/almalinux-10.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/almalinux-10.yml)                      | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [AlmaLinux 9](./almalinux-9.pkrvars.hcl)                 | [![almalinux-9](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/almalinux-9.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/almalinux-9.yml)                         | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Rocky 10](./rocky-10.pkrvars.hcl)                       | [![rocky-10](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/rocky-10.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/rocky-10.yml)                                  | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Rocky 9](./rocky-9.pkrvars.hcl)                         | [![rocky-9](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/rocky-9.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/rocky-9.yml)                                     | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Alpine 3.22](./alpine-3.22.pkrvars.hcl)                 | [![alpine-3.22](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine-3.22.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine-3.22.yml)                         | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Alpine 3.21](./alpine-3.21.pkrvars.hcl)                 | [![alpine-3.21](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine-3.21.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine-3.21.yml)                         | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Alpine 3.20](./alpine-3.20.pkrvars.hcl)                 | [![alpine-3.20](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine-3.20.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/alpine-3.20.yml)                         | ![CloudInit](https://img.shields.io/badge/CloudInit-only-brightgreen) |
| [Windows Server 2025](./windows-server-2025.pkrvars.hcl) | [![windows-server-2025](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2025.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2025.yml) | Administrator / packer                                                |
| [Windows Server 2022](./windows-server-2022.pkrvars.hcl) | [![windows-server-2022](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2022.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2022.yml) | Administrator / packer                                                |
| [Windows Server 2019](./windows-server-2019.pkrvars.hcl) | [![windows-server-2019](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2019.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-server-2019.yml) | Administrator / packer                                                |
| [Windows 11](./windows-11.pkrvars.hcl)                   | [![windows-11](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-11.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/windows-11.yml)                            | Administrator / packer                                                |
| [Talos Linux 1.12](./talos.pkrvars.hcl)                  | [![talos-1.12](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/talos-1.12.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/talos-1.12.yml)                            | None                                                                  |
| [OPNsense 25.7](./opnsense-25.7.pkrvars.hcl)             | [![opnsense-25.7](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/opnsense-25.7.yml/badge.svg)](https://github.com/Pumba98/proxmox-packer-templates/actions/workflows/opnsense-25.7.yml)                   | root / opnsense                                                       |
| [VyOS rolling](./vyos-rolling.pkrvars.hcl)               | ⚠️ No GitHub Action (rolling release)                                                                                                                                                                                            | vyos / vyos                                                           |

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
- proxmox_token
- node
- vmid

Other interesting variables are:

- pool
- proxmox_insecure_tls
- disk_storage_pool
- iso_storage_pool
- cloud_init_storage_pool
- iso_download
- Windows:
  - windows_edition
  - windows_language / windows_input_language
  - winrm_username / winrm_password (Win11 alway creates a user, Win Server will use Administrator)

See [variables.pkr.hcl](./variables.pkr.hcl) for all varaibles.

### Build a template

To build a template (e.g. `debian-13`) run:

```sh
packer build -var-file="debian-13.pkrvars.hcl" .
```

## Customization

### Windows

You can run additional setup actions for windows by creating a file `http/windows-scripts/custom/custom.ps1`.

Example:

```powershell
# debloat Windows 11: https://github.com/Raphire/Win11Debloat
& ([scriptblock]::Create((irm "https://debloat.raphi.re/"))) -RunDefaults -Sysprep -Silent
```

## Useful Tips

### Packer Webserver Forwarding

In some cases your proxmox server might be in a datacatenter. You can ssh to the proxmox server but the proxmox server can't connect to your build computer.

Set the following variables in your configuration.

- packer_http_interface to `127.0.0.1`
- packer_http_port to `8000`

**Your Proxmox Server can be reached via ssh**

Start this in a console on your build host and keep it open during build time.

```bash
# forward 127.0.0.1:8000 to the remote proxmox to 127.0.0.1:8000
ssh -N -R 127.0.0.1:8000:127.0.0.1:8000 root@proxmox
```

**Your Proxmox Server can't be reached from the build computer via ssh**

In this case you need a 2nd computer that can be reached from the proxmox computer and the build computer acting as relais.

On the proxmox host:

```bash
ssh -N -L 127.0.0.1:8000:127.0.0.1:8000 user@lighthouse
```

On the build computer:

```bash
ssh -N -R 127.0.0.1:8000:127.0.0.1:8000 user@lighthouse
```
