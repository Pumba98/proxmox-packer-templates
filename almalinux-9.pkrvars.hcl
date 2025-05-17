# renovate: datasource=custom.almaLinuxRelease
name           = "almalinux-9-template"
iso_file       = "AlmaLinux-9.6-x86_64-minimal.iso"
iso_url        = "https://repo.almalinux.org/almalinux/9.6/isos/x86_64/AlmaLinux-9.6-x86_64-minimal.iso"
iso_checksum   = "file:https://repo.almalinux.org/almalinux/9.6/isos/x86_64/CHECKSUM"
http_directory = "./http/almalinux-9"
boot_wait      = "5s"
boot_command = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
provisioner = [
  "userdel --remove --force packer"
]
