# renovate: datasource=custom.ubuntuLinuxRelease
name           = "ubuntu-18.04-template"
iso_file       = "ubuntu-18.04.5-server-amd64.iso"
iso_url        = "https://old-releases.ubuntu.com/releases/18.04/ubuntu-18.04.5-server-amd64.iso"
iso_checksum   = "file:https://old-releases.ubuntu.com/releases/18.04/SHA256SUMS"
http_content = {
  "/preseed.cfg" = {
    template = "./http/ubuntu/ubuntu-18.04-preseed.cfg"
    vars = {}
  }
}
boot_command_http = [
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
boot_command_local_file = [
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
  "preseed/file=/mnt/sr1/preseed.cfg ",
  "<enter><wait5><wait5><wait5><wait5>",

  "<leftAltOn><f2><leftAltOff>",
  "<wait><enter><wait>",
  "mkdir /mnt/sr1<enter><wait>",
  "mount /dev/sr1 /mnt/sr1<enter><wait>",
  "<leftAltOn><f1><leftAltOff><wait>",
  "<enter><wait><enter><wait><enter>",
]
provisioner = [
  "userdel --remove --force packer"
]
