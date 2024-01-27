name           = "rocky-9-template"
iso_file       = "Rocky-9.3-x86_64-minimal.iso"
iso_url        = "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.3-x86_64-minimal.iso"
iso_checksum   = "file:https://download.rockylinux.org/pub/rocky/9/isos/x86_64/CHECKSUM"
http_directory = "./http/rocky"
boot_wait      = "5s"
boot_command = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
provisioner = [
  "userdel --remove --force packer"
]