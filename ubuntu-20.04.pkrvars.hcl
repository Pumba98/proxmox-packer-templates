# renovate: datasource=custom.ubuntuLinuxRelease
name           = "ubuntu-20.04-template"
iso_file       = "ubuntu-20.04.5-live-server-amd64.iso"
iso_url        = "https://old-releases.ubuntu.com/releases/20.04/ubuntu-20.04.5-live-server-amd64.iso"
iso_checksum   = "file:https://old-releases.ubuntu.com/releases/20.04/SHA256SUMS"
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
  "<enter><enter><f6><esc><wait> ",
  "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
  "<enter>"
]
boot_command_local_file = [
  "<enter><enter><f6><esc><wait> ",
  "autoinstall ds=nocloud;h=sr1",
  "<enter>"
]
http_iso_label = "cidata"
provisioner = [
  "cloud-init clean",
  "rm /etc/cloud/cloud.cfg.d/*",
  "userdel --remove --force packer"
]
