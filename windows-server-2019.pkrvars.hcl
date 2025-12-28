name         = "windows-server-2019-template"
iso_file     = "17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
iso_url      = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
iso_checksum = "549bca46c055157291be6c22a3aaaed8330e78ef4382c99ee82c896426a1cee1"
disk_size    = "20G"
additional_iso_files = [
  {
    iso_file     = "virtio-win-0.1.285.iso"
    iso_url      = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.285-1/virtio-win-0.1.285.iso"
    iso_checksum = "e14cf2b94492c3e925f0070ba7fdfedeb2048c91eea9c5a5afb30232a3976331"
  }
]
unattended_content = {
  "/Autounattend.xml" = {
    template = "./http/windows/Autounattend-server.xml.pkrtpl"
    vars = {
      driver_version  = "2k19"
      image_name      = "Windows Server 2019 SERVERSTANDARD"
    }
  }
}
additional_cd_files = [
  {
    type = "sata"
    index = 3
    files  = ["./http/windows-scripts/*"]
  }
]
os             = "win10"
communicator   = "winrm"
http_directory = ""
cloud_init   = false
boot_command   = []
provisioner    = []
