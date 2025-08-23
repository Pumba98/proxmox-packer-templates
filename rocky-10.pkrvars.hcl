# renovate: datasource=custom.rockyLinuxRelease
name           = "rocky-10-template"
iso_file       = "Rocky-10.0-x86_64-minimal.iso"
iso_url        = "https://download.rockylinux.org/pub/rocky/10.0/isos/x86_64/Rocky-10.0-x86_64-minimal.iso"
iso_checksum   = "file:https://download.rockylinux.org/pub/rocky/10.0/isos/x86_64/CHECKSUM"
http_directory = "./http/rocky-10"
boot_wait      = "5s"
boot_command = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
provisioner = [
  "userdel --remove --force packer"
]
