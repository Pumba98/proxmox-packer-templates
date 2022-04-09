name           = "ubuntu-20.04-template"
iso_file       = "ubuntu-20.04.3-live-server-amd64.iso"
iso_url        = "https://old-releases.ubuntu.com/releases/20.04/ubuntu-20.04.3-live-server-amd64.iso"
iso_checksum   = "f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
http_directory = "./http/ubuntu-20.04"
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
