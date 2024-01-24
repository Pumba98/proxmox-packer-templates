packer {
  required_plugins {
    proxmox = {
      # renovate: githubReleaseVar repo=hashicorp/packer-plugin-proxmox
      version = "v1.1.7"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}