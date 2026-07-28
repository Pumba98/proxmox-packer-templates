# renovate: datasource=custom.rockyLinuxRelease
name           = "rocky-9-template"
iso_file       = "Rocky-9.8-x86_64-minimal.iso"
iso_url        = "https://download.rockylinux.org/pub/rocky/9.8/isos/x86_64/Rocky-9.8-x86_64-minimal.iso"
iso_checksum   = "file:https://download.rockylinux.org/pub/rocky/9.8/isos/x86_64/CHECKSUM"
http_directory = "./http/rocky-9"
boot_wait      = "5s"
boot_command = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
provisioner = [
  "cloud-init clean --logs",
  "rm -f /etc/cloud/cloud.cfg.d/99-installer.cfg",
  "rm -f /etc/ssh/ssh_host_*",
  "truncate -s 0 /etc/machine-id",
  "rm -f /var/lib/dbus/machine-id",
  "dnf clean all",
  "userdel --remove --force packer",
  "rm -f /root/.bash_history",
  "find /var/log -type f -exec truncate -s 0 {} +",
  "fstrim -a || true"
]
