terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.112.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.3.1"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.4.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.14.1"
    }
  }
  required_version = ">= 1.0"
}
