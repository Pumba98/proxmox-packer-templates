provider "proxmox" {
  endpoint = "https://${var.proxmox_host}"
  username = var.proxmox_user
  password = var.proxmox_password
}
