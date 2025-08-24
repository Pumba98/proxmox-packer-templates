# renovate: datasource=custom.rockyLinuxRelease
name           = "rocky-9-template"
iso_file       = "Rocky-9.6-x86_64-minimal.iso"
iso_url        = "https://download.rockylinux.org/pub/rocky/9.6/isos/x86_64/Rocky-9.6-x86_64-minimal.iso"
iso_checksum   = "file:https://download.rockylinux.org/pub/rocky/9.6/isos/x86_64/CHECKSUM"
http_content = {
  "/ks.cfg" = {
    template = "./http/rhel/ks.cfg.pkrtpl"
    vars = {
      # renovate: datasource=custom.rockyLinuxRelease depName=rocky-9-template
      base_os_url = "http://download.rockylinux.org/pub/rocky/9.6/BaseOS/x86_64/os/"
      # renovate: datasource=custom.rockyLinuxRelease depName=rocky-9-template
      app_stream_url = "http://download.rockylinux.org/pub/rocky/9.6/AppStream/x86_64/os/"
    }
  }
}
boot_wait      = "5s"
boot_command_http = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
boot_command_local_file = ["<tab> text inst.ks=cdrom:sr1:/ks.cfg<enter><wait>"]
provisioner = [
  "userdel --remove --force packer"
]
