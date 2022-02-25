template_name  = "ubuntu-20-04-template"
iso_file = "ubuntu-20.04.2-live-server-amd64.iso"
iso_url  = "https://releases.ubuntu.com/20.04.2/ubuntu-20.04.2-live-server-amd64.iso"
iso_checksum = "d1f2bf834bbe9bb43faf16f9be992a6f3935e65be0edece1dee2aa6eb1767423"
boot_command  = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter>"]
provisioner = [
  "userdel --remove --force packer"
]

