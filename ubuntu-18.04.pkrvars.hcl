name           = "ubuntu-18.04-template"
iso_file       = "ubuntu-18.04.5-server-amd64.iso"
iso_url        = "https://old-releases.ubuntu.com/releases/18.04/ubuntu-18.04.5-server-amd64.iso"
iso_checksum   = "8c5fc24894394035402f66f3824beb7234b757dd2b5531379cb310cedfdf0996"
http_directory = "./http/ubuntu-18.04"
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
