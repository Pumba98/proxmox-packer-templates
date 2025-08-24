# renovate: datasource=custom.rockyLinuxRelease
name           = "rocky-10-template"
iso_file       = "Rocky-10.0-x86_64-minimal.iso"
iso_url        = "https://download.rockylinux.org/pub/rocky/10.0/isos/x86_64/Rocky-10.0-x86_64-minimal.iso"
iso_checksum   = "file:https://download.rockylinux.org/pub/rocky/10.0/isos/x86_64/CHECKSUM"
http_content = {
  "/ks.cfg" = {
    template = "./http/rhel/ks.cfg.pkrtpl"
    vars = {
      # renovate: datasource=custom.rockyLinuxRelease depName=rocky-10-template
      base_os_url = "http://download.rockylinux.org/pub/rocky/10.0/BaseOS/x86_64/os/"
      # renovate: datasource=custom.rockyLinuxRelease depName=rocky-10-template
      app_stream_url = "http://download.rockylinux.org/pub/rocky/10.0/AppStream/x86_64/os/"
    }
  }
}
boot_wait      = "5s"
boot_command = [
    "c<wait> ",
    "linux /images/pxeboot/vmlinuz inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
    "<enter><wait>",
    "initrd /images/pxeboot/initrd.img",
    "<enter><wait>",
    "boot",
    "<enter>"
]
provisioner = [
  "userdel --remove --force packer"
]
