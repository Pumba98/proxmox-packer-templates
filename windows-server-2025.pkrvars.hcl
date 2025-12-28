name         = "windows-server-2025-template"
iso_file     = "26100.1742.240906-0331.ge_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
iso_url      = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1742.240906-0331.ge_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
iso_checksum = "d0ef4502e350e3c6c53c15b1b3020d38a5ded011bf04998e950720ac8579b23d"
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
      driver_version  = "2k25"
      image_name      = "Windows Server 2025 SERVERSTANDARD"
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
os             = "win11"
communicator   = "winrm"
http_directory = ""
cloud_init   = false
boot_command   = []
provisioner    = []
