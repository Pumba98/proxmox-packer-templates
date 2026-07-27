terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.3.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.4"
    }
  }
  required_version = ">= 1.0"
}
