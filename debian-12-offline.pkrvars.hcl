# renovate: datasource=custom.debianLinuxRelease
name           = "debian-12-template2"
iso_file       = "debian-12.6.0-amd64-netinst.iso"
iso_url        = "https://cdimage.debian.org/mirror/cdimage/archive/12.8.0/amd64/iso-cd/debian-12.8.0-amd64-netinst.iso"
iso_checksum   = "file:https://cdimage.debian.org/mirror/cdimage/archive/12.8.0/amd64/iso-cd/SHA256SUMS"
http_directory = "./http/debian"
boot_command = [
  "<esc><wait>",
  "install ",
  " preseed/file=/mnt/cdrom2/preseed-offline.cfg ",
  "auto ", "locale=en_US.UTF-8 ",
  "kbd-chooser/method=us ",
  "keyboard-configuration/xkb-keymap=us ",
  "netcfg/get_hostname=debian ",
  "netcfg/get_domain=local ",
  "fb=false ",
  "debconf/frontend=noninteractive ",
  "console-setup/ask_detect=false ",
  "console-keymaps-at/keymap=us ",
  "grub-installer/bootdev=/dev/sda ",
  "passwd/username=packer ",
  "passwd/user-fullname=packer ",
  "passwd/user-password=packer ",
  "passwd/user-password-again=packer ",
  "<enter><wait5><wait5>",

  "<leftAltOn><f2><leftAltOff>",
  "<wait><enter><wait>",
  "mkdir /mnt/cdrom2<enter><wait>",
  "mount /dev/sr1 /mnt/cdrom2<enter><wait>",
  "<leftAltOn><f1><leftAltOff><wait>",
  "<enter><wait><enter><wait><enter>",
]
provisioner = [
  "userdel --remove --force packer"
]


additional_cd_files = [
  {
    device = "sata3"
    files  = ["./http/debian/*"]
  }
]
