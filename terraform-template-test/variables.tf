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

variable "windows" {
  description = "Whether the template is a Windows template. Windows templates have no cloud-init drive and are tested over WinRM instead of SSH."
  type        = bool
  default     = false
}

variable "node" {
  description = "Name of the Proxmox node to clone the test VM onto."
  type        = string
  default     = "proxmox"
}

variable "pool" {
  description = "Proxmox pool to place the test VM in."
  type        = string
  default     = "staging"
}

variable "cloud_init_storage_pool" {
  description = "Datastore for the cloud-init drive of the test VM. Matches PKR_VAR_cloud_init_storage_pool. Unused for Windows templates."
  type        = string
  default     = "local-lvm"
}

variable "ssh_username" {
  description = "Username provisioned via cloud-init and used for the SSH connection test."
  type        = string
  default     = "template"
}

variable "ssh_password" {
  description = "Password provisioned via cloud-init and used for the SSH connection test."
  type        = string
  default     = "test"
  sensitive   = true
}

variable "winrm_username" {
  description = "Username baked into the Windows template by packer, used for the WinRM connection test."
  type        = string
  default     = "Administrator"
}

variable "winrm_password" {
  description = "Password baked into the Windows template by packer, used for the WinRM connection test."
  type        = string
  default     = "packer"
  sensitive   = true
}

variable "agent_timeout" {
  description = "How long to wait for the QEMU guest agent to report an IP address."
  type        = string
  default     = "5m"
}

variable "connection_timeout" {
  description = "How long to wait for the SSH/WinRM connection to succeed."
  type        = string
  default     = "5m"
}

variable "test_reboot" {
  description = "Reboot the VM and verify it comes back on the same IP address."
  type        = bool
  default     = true
}

variable "reboot_timeout" {
  description = "How long to wait for the VM to come back after the reboot."
  type        = string
  default     = "10m"
}

variable "packer_username" {
  description = "The throwaway build user packer connects as, which the template provisioners must delete. Matches PKR_VAR_ssh_username."
  type        = string
  default     = "packer"
}

variable "test_machine_id" {
  description = "Clone a second VM and verify the two clones do not share an identity (machine-id, DHCP lease, MAC)."
  type        = bool
  default     = true
}
