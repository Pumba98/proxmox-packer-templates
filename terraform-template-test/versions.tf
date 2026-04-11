terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.101.1"
    }
  }
  required_version = ">= 1.0"
}
