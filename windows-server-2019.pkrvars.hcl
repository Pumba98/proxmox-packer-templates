name         = "windows-server-2019-template"
iso_file     = "17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
iso_url      = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
iso_checksum = "549bca46c055157291be6c22a3aaaed8330e78ef4382c99ee82c896426a1cee1"
iso_download = true
disk_size    = "20G"
additional_iso_files = [
  {
    device       = "sata4"
    iso_file     = "virtio-win-0.1.185.iso"
    iso_url      = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/virtio-win-0.1.185.iso"
    iso_checksum = "af2b3cc9fa7905dea5e58d31508d75bba717c2b0d5553962658a47aebc9cc386"
  }
]
additional_cd_files = [
  {
    device = "sata3"
    files  = ["./http/windows-server-2019/*"]
  }
]
os             = "win10"
communicator   = "winrm"
http_directory = ""
boot_command   = []
provisioner    = []
