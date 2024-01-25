# renovate: datasource=custom.ubuntuLinuxRelease
name           = "ubuntu-20.04-template"
iso_file       = "ubuntu-20.04.5-live-server-amd64.iso"
iso_url        = "https://old-releases.ubuntu.com/releases/20.04/ubuntu-20.04.5-live-server-amd64.iso"
iso_checksum   = "file:https://old-releases.ubuntu.com/releases/20.04/SHA256SUMS"
http_directory = "./http/ubuntu"
boot_wait      = "5s"
boot_command = [
  "<enter><enter><f6><esc><wait> ",
  "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
  "<enter>"
]
provisioner = [
  "cloud-init clean",
  "rm /etc/cloud/cloud.cfg.d/*",
  "userdel --remove --force packer"
]
