name         = "windows-server-2022-template"
iso_file     = "SERVER_EVAL_x64FRE_en-us.iso"
iso_url      = "https://software-static.download.prss.microsoft.com/sg/download/888969d5-f34g-4e03-ac9d-1f9786c66749/SERVER_EVAL_x64FRE_en-us.iso"
iso_checksum = "3e4fa6d8507b554856fc9ca6079cc402df11a8b79344871669f0251535255325"
iso_download = true
disk_size    = "20G"
additional_iso_files = [
  {
    iso_file     = "virtio-win-0.1.285.iso"
    iso_url      = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.285-1/virtio-win-0.1.285.iso"
    iso_checksum = "e14cf2b94492c3e925f0070ba7fdfedeb2048c91eea9c5a5afb30232a3976331"
  }
]
additional_cd_files = [
  {
    device = "sata3"
    files  = ["./http/windows-server-2022/*"]
  }
]
os             = "win10"
communicator   = "winrm"
http_directory = ""
boot_command   = []
provisioner    = []
