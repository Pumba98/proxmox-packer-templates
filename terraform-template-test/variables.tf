variable "proxmox_host" {
  description = "IP and Port of the Proxmox host."
  type        = string
  sensitive   = true
}

variable "proxmox_user" {
  description = "Username when authenticating to Proxmox, including the realm."
  type        = string
  sensitive   = true
}

variable "proxmox_password" {
  description = "Password for the Proxmox user."
  type        = string
  sensitive   = true
}

variable "template_id" {
  description = "ID of the VM template to use."
  type        = number
}
