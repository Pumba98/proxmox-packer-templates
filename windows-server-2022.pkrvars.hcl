name         = "windows-server-2022-template"
iso_file     = "SERVER_EVAL_x64FRE_en-us.iso"
iso_url      = "https://software-static.download.prss.microsoft.com/sg/download/888969d5-f34g-4e03-ac9d-1f9786c66749/SERVER_EVAL_x64FRE_en-us.iso"
iso_checksum = "3e4fa6d8507b554856fc9ca6079cc402df11a8b79344871669f0251535255325"
iso_download = true
disk_size    = "20G"
additional_iso_files = [
  {
    device       = "sata4"
    iso_file     = "virtio-win-0.1.240.iso"
    iso_url      = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.240-1/virtio-win-0.1.240.iso"
    iso_checksum = "ebd48258668f7f78e026ed276c28a9d19d83e020ffa080ad69910dc86bbcbcc6"
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
