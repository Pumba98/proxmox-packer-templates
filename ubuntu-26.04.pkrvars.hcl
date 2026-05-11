# renovate: datasource=custom.ubuntuLinuxRelease
name           = "ubuntu-26.04-template"
iso_file       = "ubuntu-26.04-live-server-amd64.iso"
iso_url        = "https://releases.ubuntu.com/releases/26.04/ubuntu-26.04-live-server-amd64.iso"
iso_checksum   = "file:https://releases.ubuntu.com/releases/26.04/SHA256SUMS"
# iso_file       = "ubuntu-26.04.1-live-server-amd64.iso"
# iso_url        = "https://old-releases.ubuntu.com/releases/26.04/ubuntu-26.04.1-live-server-amd64.iso"
# iso_checksum   = "file:https://old-releases.ubuntu.com/releases/26.04/SHA256SUMS"
http_directory = "./http/ubuntu"
boot_wait      = "5s"
boot_command = [
  "c<wait> ",
  "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
  "<enter><wait>",
  "initrd /casper/initrd",
  "<enter><wait>",
  "boot",
  "<enter>"
]
provisioner = [
  "cloud-init clean",
  "rm /etc/cloud/cloud.cfg.d/*",
  "userdel --remove --force packer"
]
