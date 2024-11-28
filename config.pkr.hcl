packer {
  required_plugins {
    proxmox = {
      # renovate: githubReleaseVar repo=hashicorp/packer-plugin-proxmox
      version = "v1.2.1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}