packer {
  required_plugins {
    proxmox = {
      # renovate: githubReleaseVar repo=hashicorp/packer-plugin-proxmox
      version = "1.0.5"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}