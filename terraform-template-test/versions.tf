terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.114.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.3.2"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.4.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.14.2"
    }
  }
  required_version = ">= 1.0"
}
