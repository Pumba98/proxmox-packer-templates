# renovate: datasource=custom.debianLinuxRelease
name           = "debian-12-template"
iso_file       = "debian-12.11.0-amd64-netinst.iso"
iso_url        = "https://cdimage.debian.org/mirror/cdimage/archive/12.11.0/amd64/iso-cd/debian-12.11.0-amd64-netinst.iso"
iso_checksum   = "file:https://cdimage.debian.org/mirror/cdimage/archive/12.11.0/amd64/iso-cd/SHA256SUMS"
http_directory = "./http/debian"
http_content = {
  "preseed.cfg" = {
    template = "./http/debian/preseed.cfg.pkrtpl.hcl"
    vars = {}
  }
}
http_enabled = false

boot_command_http = [
  "<esc><wait>",
  "install ",
  " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
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
  "<enter>"
]

boot_command_local_file = [
  "<esc><wait>",
  "install ",
  " preseed/file=/mnt/cdrom2/preseed.cfg ",
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
