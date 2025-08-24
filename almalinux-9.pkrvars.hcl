# renovate: datasource=custom.almaLinuxRelease
name           = "almalinux-9-template"
iso_file       = "AlmaLinux-9.6-x86_64-minimal.iso"
iso_url        = "https://repo.almalinux.org/almalinux/9.6/isos/x86_64/AlmaLinux-9.6-x86_64-minimal.iso"
iso_checksum   = "file:https://repo.almalinux.org/almalinux/9.6/isos/x86_64/CHECKSUM"
http_content = {
  "/ks.cfg" = {
    template = "./http/rhel/ks.cfg.pkrtpl"
    vars = {
      # renovate: datasource=custom.rockyLinuxRelease depName=almalinux-9-template
      base_os_url = "http://repo.almalinux.org/almalinux/9.6/BaseOS/x86_64/os/"
      # renovate: datasource=custom.rockyLinuxRelease depName=almalinux-9-template
      app_stream_url = "http://repo.almalinux.org/almalinux/9.6/AppStream/x86_64/os/"
    }
  }
}
boot_wait      = "5s"
boot_command_http = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
boot_command_local_file = ["<tab> text inst.ks=cdrom:sr1:/ks.cfg<enter><wait>"]
provisioner = [
  "userdel --remove --force packer"
]
