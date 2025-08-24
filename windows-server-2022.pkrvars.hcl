name         = "windows-server-2022-template"
iso_file     = "SERVER_EVAL_x64FRE_en-us.iso"
iso_url      = "https://software-static.download.prss.microsoft.com/sg/download/888969d5-f34g-4e03-ac9d-1f9786c66749/SERVER_EVAL_x64FRE_en-us.iso"
iso_checksum = "3e4fa6d8507b554856fc9ca6079cc402df11a8b79344871669f0251535255325"
http_content = {
  "/Autounattend.xml" = {
    template = "./http/windows-server/Autounattend.xml.pkrtpl"
    vars = {
      driver_version = "2k22"
      image_name    = "Windows Server 2022 SERVERSTANDARD"
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
