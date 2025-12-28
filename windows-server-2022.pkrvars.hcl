name         = "windows-server-2022-template"
iso_file     = "SERVER_EVAL_x64FRE_en-us.iso"
iso_url      = "https://software-static.download.prss.microsoft.com/sg/download/888969d5-f34g-4e03-ac9d-1f9786c66749/SERVER_EVAL_x64FRE_en-us.iso"
iso_checksum = "3e4fa6d8507b554856fc9ca6079cc402df11a8b79344871669f0251535255325"
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
      driver_version  = "2k22"
      image_name      = "Windows Server 2022 SERVERSTANDARD"
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
