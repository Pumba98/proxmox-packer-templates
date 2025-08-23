name         = "windows-server-2025-template"
iso_file     = "26100.1742.240906-0331.ge_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
iso_url      = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1742.240906-0331.ge_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
iso_checksum = "d0ef4502e350e3c6c53c15b1b3020d38a5ded011bf04998e950720ac8579b23d"
iso_download = true
disk_size    = "20G"
additional_iso_files = [
  {
    iso_file     = "virtio-win-0.1.271.iso"
    iso_url      = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.271-1/virtio-win-0.1.271.iso"
    iso_checksum = "bbe6166ad86a490caefad438fef8aa494926cb0a1b37fa1212925cfd81656429"
  }
]
additional_cd_files = [
  {
    device = "sata3"
    files  = ["./http/windows-server-2025/*"]
  }
]
os             = "win11"
communicator   = "winrm"
http_directory = ""
boot_command   = []
provisioner    = []
