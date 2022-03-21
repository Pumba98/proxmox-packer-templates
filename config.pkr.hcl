packer {
  required_plugins {
    proxmox = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}