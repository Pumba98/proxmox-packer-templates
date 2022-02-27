template_name = "ubuntu-18-04-template"
iso_file      = "ubuntu-18.04.4-server-amd64.iso"
iso_url       = "https://old-releases.ubuntu.com/releases/18.04.4/ubuntu-18.04.4-server-amd64.iso"
iso_checksum  = "e2ecdace33c939527cbc9e8d23576381c493b071107207d2040af72595f8990b"
boot_command = [
  "<esc><wait>",
  "<esc><wait>",
  "<enter><wait>",
  "/install/vmlinuz ",
  "initrd=/install/initrd.gz ",
  "priority=critical ",
  "locale=en_US ",
  "passwd/username=packer ",
  "passwd/user-fullname=packer ",
  "passwd/user-password=packer ",
  "passwd/user-password-again=packer ",
  "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
  "<enter>"
]
provisioner = [
  "userdel --remove --force packer"
]
