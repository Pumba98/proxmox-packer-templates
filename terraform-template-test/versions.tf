terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.102.0"
    }
  }
  required_version = ">= 1.0"
}
