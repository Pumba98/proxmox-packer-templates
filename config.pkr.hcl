packer {
  required_plugins {
    proxmox = {
      # renovate: githubReleaseVar repo=hashicorp/packer-plugin-proxmox
      version = "v1.1.8"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}