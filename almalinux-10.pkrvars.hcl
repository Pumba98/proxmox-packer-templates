# renovate: datasource=custom.almaLinuxRelease
name           = "almalinux-10-template"
iso_file       = "AlmaLinux-10.2-x86_64-minimal.iso"
iso_url        = "https://repo.almalinux.org/almalinux/10.2/isos/x86_64/AlmaLinux-10.2-x86_64-minimal.iso"
iso_checksum   = "file:https://repo.almalinux.org/almalinux/10.2/isos/x86_64/CHECKSUM"
http_directory = "./http/almalinux-10"
boot_wait      = "5s"
boot_command = [
    "c<wait> ",
    "linux /images/pxeboot/vmlinuz inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
    "<enter><wait>",
    "initrd /images/pxeboot/initrd.img",
    "<enter><wait>",
    "boot",
    "<enter>"
]
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
