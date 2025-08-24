# renovate: datasource=custom.almaLinuxRelease
name           = "almalinux-10-template"
iso_file       = "AlmaLinux-10.0-x86_64-minimal.iso"
iso_url        = "https://repo.almalinux.org/almalinux/10.0/isos/x86_64/AlmaLinux-10.0-x86_64-minimal.iso"
iso_checksum   = "file:https://repo.almalinux.org/almalinux/10.0/isos/x86_64/CHECKSUM"
http_content = {
  "/ks.cfg" = {
    template = "./http/rhel/ks.cfg.pkrtpl"
    vars = {
      # renovate: datasource=custom.rockyLinuxRelease depName=almalinux-10-template
      base_os_url = "http://repo.almalinux.org/almalinux/10.0/BaseOS/x86_64/os/"
      # renovate: datasource=custom.rockyLinuxRelease depName=almalinux-10-template
      app_stream_url = "http://repo.almalinux.org/almalinux/10.0/AppStream/x86_64/os/"
    }
  }
}
boot_wait      = "5s"
boot_command_http = [
    "c<wait> ",
    "linux /images/pxeboot/vmlinuz inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
    "<enter><wait>",
    "initrd /images/pxeboot/initrd.img",
    "<enter><wait>",
    "boot",
    "<enter>"
]
boot_command_local_file = [
    "c<wait> ",
    "linux /images/pxeboot/vmlinuz inst.text inst.ks=cdrom:sr1:/ks.cfg",
    "<enter><wait>",
    "initrd /images/pxeboot/initrd.img",
    "<enter><wait>",
    "boot",
    "<enter>"
]
provisioner = [
  "userdel --remove --force packer"
]
