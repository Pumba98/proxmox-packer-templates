variable "template_name" {
  type = string
}

variable "vmid" {
  type = number
}

variable "proxmox_api_user" {
  type = string
}

variable "proxmox_api_password" {
  type = string
}

variable "proxmox_host" {
  type = string
}

variable "proxmox_node_name" {
  type = string
}

variable "proxmox_insecure_tls" {
  type    = bool
  default = false
}

variable "boot_command" {
  type = list(string)
}

variable "provisioner" {
  type = list(string)
}

variable "os" {
  type    = string
  default = "l26"
}

variable "iso_download" {
  type    = bool
  default = true
}

variable "iso_url" {
  type = string
}

variable "iso_checksum" {
  type = string
}

variable "iso_file" {
  type = string
}

variable "bind_address" {
  type    = string
  default = "0.0.0.0"
}

variable "bind_max_port" {
  type    = number
  default = 9000
}

variable "bind_min_port" {
  type    = number
  default = 8000
}

variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "cloud_init" {
  type    = bool
  default = true
}

variable "cloud_init_storage_pool" {
  type    = string
  default = "local"
}

variable "cores" {
  type    = number
  default = 2
}

variable "cpu_type" {
  type    = string
  default = "host"
}

variable "datastore" {
  type    = string
  default = "local"
}

variable "datastore_type" {
  type    = string
  default = "directory"
}

variable "disable_kvm" {
  type    = bool
  default = false
}

variable "disk_cache" {
  type    = string
  default = "none"
}

variable "disk_format" {
  type    = string
  default = "qcow2"
}

variable "disk_size" {
  type    = string
  default = "5G"
}

variable "disk_type" {
  type    = string
  default = "scsi"
}

variable "iso_storage_pool" {
  type    = string
  default = "local"
}

variable "memory" {
  type    = number
  default = 2048
}

variable "network_adapter" {
  type    = string
  default = "vmbr0"
}

variable "network_adapter_model" {
  type    = string
  default = "virtio"
}

variable "proxmox_pool" {
  type    = string
  default = ""
}

variable "scsi_controller" {
  type    = string
  default = "virtio-scsi-pci"
}

variable "sockets" {
  type    = number
  default = 1
}

variable "start_on_boot" {
  type    = bool
  default = false
}

variable "vga_memory" {
  type    = number
  default = 32
}

variable "vga_type" {
  type    = string
  default = "std"
}

variable "http_directory" {
  type    = string
  default = "./http"
}

variable "additional_iso_files" {
  type = list(object({
    device       = string
    iso_file     = string
    cd_files     = list(string)
  }))
  default = []
}

variable "communicator" {
  type    = string
  default = "ssh"
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "ssh_password" {
  type    = string
  default = "packer"
}

variable "ssh_timeout" {
  type    = string
  default = "30m"
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}

variable "winrm_password" {
  type    = string
  default = "packer"
}