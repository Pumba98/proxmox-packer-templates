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
  "cloud-init clean --logs",
  "rm /etc/cloud/cloud.cfg.d/*",
  "rm -f /etc/ssh/ssh_host_*",
  "truncate -s 0 /etc/machine-id",
  "rm -f /var/lib/dbus/machine-id",
  "apt-get clean",
  "userdel --remove --force packer",
  "rm -f /root/.bash_history",
  "find /var/log -type f -exec truncate -s 0 {} +",
  "fstrim -a || true"
]
