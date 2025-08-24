name         = "windows-server-2019-template"
iso_file     = "17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
iso_url      = "https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
iso_checksum = "549bca46c055157291be6c22a3aaaed8330e78ef4382c99ee82c896426a1cee1"
http_content = {
  "/Autounattend.xml" = {
    template = "./http/windows-server/Autounattend.xml.pkrtpl"
    vars = {
      driver_version = "2k19"
      image_name    = "Windows Server 2019 SERVERSTANDARD"
    }
  }
  "/setup.ps1" = {
    template = "./http/windows-server/setup.ps1"
    vars = {}
  }
}
http_enabled = false
additional_iso_files = [
  {
    iso_file     = "virtio-win-0.1.271.iso"
    iso_url      = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.271-1/virtio-win-0.1.271.iso"
    iso_checksum = "bbe6166ad86a490caefad438fef8aa494926cb0a1b37fa1212925cfd81656429"
  }
]
os             = "win10"
communicator   = "winrm"
disk_size    = "20G"
