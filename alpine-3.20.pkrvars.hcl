# renovate: datasource=custom.alpineLinuxRelease
name           = "alpine-3.20-template"
iso_file       = "alpine-virt-3.20.8-x86_64.iso"
iso_url        = "https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-virt-3.20.8-x86_64.iso"
iso_checksum   = "file:https://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-virt-3.20.8-x86_64.iso.sha256"
http_directory = "./http/alpine"
boot_command = [
  "root<enter><wait>",
  "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>",
  "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers<enter><wait>",
  "setup-alpine -f answers<enter><wait5>",
  "packer<enter><wait>",
  "packer<enter><wait5>",
  "<enter><wait5>",
  "y<enter><wait5>",
  "rc-service sshd stop <enter>",
  "mount /dev/vg0/lv_root /mnt<enter>",
  "mount --bind /dev/ /mnt/dev<enter>",
  "chroot /mnt<enter><wait>",
  "echo https://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community/ >> /etc/apk/repositories<enter><wait>",
  "apk update<enter><wait>",
  "apk upgrade<enter><wait>",
  "apk add --no-cache qemu-guest-agent<enter><wait>",
  "rc-update add qemu-guest-agent<enter>",
  "apk add --no-cache sudo<enter>",
  "echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel<enter>",
  "adduser packer -H -D<enter>",
  "echo packer:packer | chpasswd<enter>",
  "adduser packer wheel<enter>",
  "exit<enter>",
  "umount /mnt/dev<enter><wait1>",
  "umount /mnt<enter><wait1>",
  "reboot<enter>"
]
provisioner = [
  "apk add --no-cache cloud-init util-linux e2fsprogs-extra",
  "setup-cloud-init",
  "echo \"datasource_list: ['NoCloud']\" > /etc/cloud/cloud.cfg.d/02-datasource.cfg",
  "echo \"PasswordAuthentication yes\" > /etc/ssh/sshd_config.d/01-password-auth.conf",
  "passwd -l root",
  "deluser --remove-home packer"
]
