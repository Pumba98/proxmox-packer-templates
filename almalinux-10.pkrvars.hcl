# renovate: datasource=custom.almaLinuxRelease
name           = "almalinux-10-template"
iso_file       = "AlmaLinux-10.0-x86_64-minimal.iso"
iso_url        = "https://repo.almalinux.org/almalinux/10.0/isos/x86_64/AlmaLinux-10.0-x86_64-minimal.iso"
iso_checksum   = "file:https://repo.almalinux.org/almalinux/10.0/isos/x86_64/CHECKSUM"
http_directory = "./http/almalinux-10"
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
