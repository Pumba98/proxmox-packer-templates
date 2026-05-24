terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.107.0"
    }
  }
  required_version = ">= 1.0"
}
