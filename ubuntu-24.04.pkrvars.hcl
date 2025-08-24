# renovate: datasource=custom.ubuntuLinuxRelease
name           = "ubuntu-24.04-template"
iso_file       = "ubuntu-24.04.1-live-server-amd64.iso"
iso_url        = "https://old-releases.ubuntu.com/releases/24.04/ubuntu-24.04.1-live-server-amd64.iso"
iso_checksum   = "file:https://old-releases.ubuntu.com/releases/24.04/SHA256SUMS"
http_content = {
  "/meta-data" = {
    template = "./http/ubuntu/meta-data"
    vars = {}
  },
  "/user-data" = {
    template = "./http/ubuntu/user-data"
    vars = {}
  }
}
boot_wait      = "5s"
boot_command_http = [
  "c<wait> ",
  "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
  "<enter><wait>",
  "initrd /casper/initrd",
  "<enter><wait>",
  "boot",
  "<enter>"
]
boot_command_local_file = [
  "c<wait> ",
  "linux /casper/vmlinuz --- autoinstall ds='nocloud;h=sr1'",
  "<enter><wait>",
  "initrd /casper/initrd",
  "<enter><wait>",
  "boot",
  "<enter>"
]
http_iso_label = "cidata"
provisioner = [
  "cloud-init clean",
  "rm /etc/cloud/cloud.cfg.d/*",
  "userdel --remove --force packer"
]
