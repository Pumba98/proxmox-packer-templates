name         = "windows-11-template"
iso_file     = "26200.6584.250915-1905.25h2_ge_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
iso_url      = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26200.6584.250915-1905.25h2_ge_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
iso_checksum = "a61adeab895ef5a4db436e0a7011c92a2ff17bb0357f58b13bbc4062e535e7b9"
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
    files  = ["./http/windows-11/*"]
  }
]
os             = "win11"
communicator   = "winrm"
http_directory = ""
boot_command   = []
provisioner    = []
