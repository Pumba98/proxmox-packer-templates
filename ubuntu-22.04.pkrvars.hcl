name           = "ubuntu-22.04-template"
iso_file       = "ubuntu-22.04.2-live-server-amd64.iso"
iso_url        = "https://old-releases.ubuntu.com/releases/22.04/ubuntu-22.04.2-live-server-amd64.iso"
iso_checksum   = "5e38b55d57d94ff029719342357325ed3bda38fa80054f9330dc789cd2d43931"
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
