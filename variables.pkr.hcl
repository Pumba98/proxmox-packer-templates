variable "vmid" {
  description = "The ID used to reference the virtual machine. If not given, the next free ID on the node will be used."
  type        = number
  default     = 0
}

variable "name" {
  description = "The name of the VM within Proxmox."
  type        = string
}

variable "description" {
  description = "The description of the VM. Shows as the 'Notes' field in the Proxmox GUI."
  type        = string
  default     = ""
}

variable "node" {
  description = "The name of the Proxmox Node on which to place the VM."
  type        = string
}

variable "pool" {
  description = "The resource pool to which the VM will be added."
  type        = string
  default     = ""
}

variable "cpu_type" {
  description = "The type of CPU to emulate in the Guest."
  type        = string
  default     = "host"
}

variable "cpu_sockets" {
  description = "The number of CPU sockets to allocate to the VM."
  type        = number
  default     = 1
}

variable "cpu_cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM."
  type        = number
  default     = 2
}

variable "memory" {
  description = "The amount of memory to allocate to the VM in Megabytes."
  type        = number
  default     = 2048
}

variable "disk_storage_pool" {
  description = "The name of the storage pool on which to store the disks."
  type        = string
  default     = "local"
}

variable "disk_size" {
  description = "The size of the created disk."
  type        = string
  default     = "5G"
}

variable "disk_format" {
  description = "The drive's backing file's data format."
  type        = string
  default     = "qcow2"
}

variable "disk_type" {
  description = "The type of disk device to add."
  type        = string
  default     = "scsi"
}

variable "disk_cache" {
  description = "The drive's cache mode."
  type        = string
  default     = "none"
}

variable "network_adapter" {
  description = "Bridge to which the network device should be attached."
  type        = string
  default     = "vmbr0"
}

variable "network_adapter_model" {
  description = "Network Card Model."
  type        = string
  default     = "virtio"
}

variable "network_adapter_mac" {
  description = "Override the randomly generated MAC Address for the VM."
  type        = string
  default     = null
}

variable "network_adapter_vlan" {
  description = "The VLAN tag to apply to packets on this device."
  type        = number
  default     = -1
}

variable "network_adapter_firewall" {
  description = "Whether to enable the Proxmox firewall on this network device."
  type        = bool
  default     = false
}

variable "vga_type" {
  description = "The type of display to virtualize."
  type        = string
  default     = "std"
}

variable "vga_memory" {
  description = "Sets the VGA memory (in MiB)."
  type        = number
  default     = 32
}

variable "os" {
  description = "The operating system."
  type        = string
  default     = "l26"
}

variable "scsi_controller" {
  description = "The SCSI controller model to emulate."
  type        = string
  default     = "virtio-scsi-pci"
}

variable "start_at_boot" {
  description = "Whether to have the VM startup after the PVE node starts."
  type        = bool
  default     = true
}

variable "qemu_agent" {
  description = "Whether to enable the QEMU Guest Agent. qemu-guest-agent daemon must run the in the quest."
  type        = bool
  default     = true
}

variable "bios" {
  description = "Set the machine bios."
  type        = string
  default     = "seabios"
}






variable "proxmox_host" {
  description = "IP and Port of the Proxmox host."
  type        = string
}

variable "proxmox_user" {
  description = "Username when authenticating to Proxmox, including the realm."
  type        = string
}

variable "proxmox_password" {
  description = "Password for the Proxmox user."
  type        = string
  default     = ""
}

variable "proxmox_token" {
  description = "Proxmox Token if you are using API Tokens. If both are set, `proxmox_token` takes precedence."
  type        = string
  default     = ""
}

variable "proxmox_insecure_tls" {
  description = "Skip validating the certificate."
  type        = bool
  default     = false
}

variable "iso_download" {
  description = "Wether to download from iso_url or use the existing iso_file in the iso_storage_pool."
  type        = bool
  default     = true
}

variable "iso_download_pve" {
  description = "Download the specified `iso_url` directly from the PVE node."
  type        = bool
  default     = false
}

variable "iso_url" {
  description = "URL to the iso file."
  type        = string
}

variable "iso_checksum" {
  description = "Checksum of the iso file"
  type        = string
}

variable "iso_file" {
  description = "Name of the iso file"
  type        = string
}

variable "iso_storage_pool" {
  description = "Storage pool of the iso file"
  type        = string
  default     = "local"
}

variable "iso_unmount" {
  description = "Wether to remove the mounted ISO from the template after finishing."
  type        = bool
  default     = true
}

variable "cloud_init" {
  description = "Wether to add a Cloud-Init CDROM drive after the virtual machine has been converted to a template."
  type        = bool
  default     = true
}

variable "cloud_init_storage_pool" {
  description = "Name of the Proxmox storage pool to store the Cloud-Init CDROM on."
  type        = string
  default     = "local"
}

variable "additional_iso_files" {
  description = "Additional ISO files attached to the virtual machine."
  type = list(object({
    iso_file     = string
    iso_url      = string
    iso_checksum = string
  }))
  default = []
}

variable "additional_cd_files" {
  description = "Additional files attached to the virtual machine as iso."
  type = list(object({
    type   = string
    index  = number
    files  = list(string)
  }))
  default = []
}

variable "boot_command" {
  description = "The keys to type when the virtual machine is first booted in order to start the OS installer."
  type        = list(string)
}

variable "boot_wait" {
  description = "The time to wait before typing boot_command."
  type        = string
  default     = "10s"
}

variable "task_timeout" {
  description = "The timeout for Promox API operations, e.g. clones"
  type        = string
  default     = "5m"
}

variable "http_directory" {
  description = "Path to a directory to serve using an HTTP server."
  type        = string
  default     = "./http"
}

variable "unattended_content" {
  description = "Key/Values for the windows unattended cd with the Autounattend.xml file."
  type        = map(object({
                  template = string
                  vars = map(string)
                }))
  default     = {}
}

variable "communicator" {
  description = "The packer communicator to use"
  type        = string
  default     = "ssh"
}

variable "ssh_username" {
  description = "The ssh username to connect to the guest"
  type        = string
  default     = "packer"
}

variable "ssh_password" {
  description = "The ssh password to connect to the guest"
  type        = string
  default     = "packer"
}

variable "ssh_timeout" {
  description = "The timeout waiting for ssh connection"
  type        = string
  default     = "30m"
}

variable "winrm_username" {
  description = "The winrm username to connect to the guest. Keep 'Administrator' for Windows Server."
  type        = string
  default     = "Administrator"
}

variable "winrm_password" {
  description = "The winrm password to connect to the guest."
  type        = string
  default     = "packer"
}

variable "winrm_insecure" {
  description = "Skip validating the winrm ssl certificate."
  type        = bool
  default     = true
}

variable "winrm_use_ssl" {
  description = "Use winrm ssl connection."
  type        = bool
  default     = false
}

variable "windows_edition" {
  description = "Windows edition of the ISO file to install (this is usefull to overwrite for Windows 11 Pro or Server Core/Datacenter)."
  type        = string
  default     = ""
}

variable "windows_language" {
  description = "Windows language to use. The ISO file must contain this lanugage."
  type        = string
  default     = "en-US"
}

variable "windows_input_language" {
  description = "Windows language for the keyboard to use. The ISO file must contain this lanugage."
  type        = string
  default     = "en-US"
}

variable "provisioner" {
  description = "The packer provisioner commands."
  type        = list(string)
}

variable "packer_http_interface" {
  description = "Name of the network interface that Packer gets HTTPIP from. Defaults to the first non loopback interface."
  type        = string
  default     = ""
}

variable "packer_http_bind_address" {
  description = "This is the bind address for the HTTP server. Defaults to 0.0.0.0 so that it will work with any network interface."
  type        = string
  default     = ""
}

variable "packer_http_port" {
  description = "Port the HTTP server started to serve the http_directory (required only for ssh portworarding)."
  type        = number
  default     = -1
}
