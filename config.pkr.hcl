packer {
  required_plugins {
    proxmox = {
      # renovate: githubReleaseVar repo=hashicorp/packer-plugin-proxmox
      version = "v1.0.6"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}