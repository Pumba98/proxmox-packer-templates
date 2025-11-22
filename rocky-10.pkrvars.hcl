# renovate: datasource=custom.rockyLinuxRelease
name           = "rocky-10-template"
iso_file       = "Rocky-10.1-x86_64-minimal.iso"
iso_url        = "https://download.rockylinux.org/pub/rocky/10.1/isos/x86_64/Rocky-10.1-x86_64-minimal.iso"
iso_checksum   = "file:https://download.rockylinux.org/pub/rocky/10.1/isos/x86_64/CHECKSUM"
http_directory = "./http/rocky-10"
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
