template_name = "windows-server-2019-template"
iso_file      = "win-server-2019_x64FRE_en-us.iso"
iso_url       = ""
iso_checksum  = ""
iso_download  = false
disk_size     = "20G"
additional_iso_files = [
  {
    device   = "sata4"
    iso_file = "virtio-win-0.1.185.iso"
  }
]
additional_cd_files = [
  {
    device = "sata3"
    files  = ["./http/windows-server-2019/*"]
  }
]
communicator   = "winrm"
http_directory = ""
boot_command   = []
provisioner    = []
