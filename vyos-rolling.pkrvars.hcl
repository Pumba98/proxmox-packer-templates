# this is a rolling release - you need to setup these variables e.g.

# curl -s https://api.github.com/repos/vyos/vyos-nightly-build/releases \
#  | jq -r '.[0] | .tag_name as $ver | .assets[] | select(.name | endswith(".iso")) | "name         = \"vyos-\($ver)-template\"\niso_file     = \"\(.name)\"\niso_url      = \"\(.browser_download_url)\"\niso_checksum = \"\(.digest)\""' \
#    > vyos-nightly-build.pkrvars.hcl

# tested with
# name         = "vyos-2025.12.23-0021-rolling-template"
# iso_file     = "vyos-2025.12.23-0021-rolling-generic-amd64.iso"
# iso_url      = "https://github.com/vyos/vyos-nightly-build/releases/download/2025.12.23-0021-rolling/vyos-2025.12.23-0021-rolling-generic-amd64.iso"
# iso_checksum = "sha256:1c602a0eed0026663cdcbd1ef8acc23b75f1ce8cce3a1bf33654aaa19224fe6f"

http_directory = "./http/vyos"

# default credentials - change this after installation
ssh_username   = "vyos"
ssh_password   = "vyos"

#################################################
#
# - eth0 and dns is dhcp
# - ssh is enable at boot time
# - qemu guest agent is installed (debian bookworm - this might change in the future)
#

boot_wait      = "60s"
boot_command   = [
  # login
  "vyos<wait>",
  "<enter><wait>",
  "vyos<wait>",
  "<enter><wait>",

  # installer
  "install image<wait>",
  "<enter><wait>",

  # confirm with yes
  "<wait5>",
  "y<wait>",
  "<enter><wait>",

  # default name
  "<wait5>",
  "<enter><wait>",

  # default password
  "<wait5>",
  "vyos<wait>",
  "<enter><wait>",

  # confirm password
  "<wait5>",
  "vyos<wait>",
  "<enter><wait>",

  # default KVM style console
  "<wait5>",
  "<enter><wait>",

  # default hard disk
  "<wait5>",
  "<enter><wait>",

  # confirm delete with yes
  "<wait5>",
  "y<wait>",
  "<enter><wait>",

  # use all space
  "<wait5>",
  "<enter><wait>",

  # wait for partition
  "<wait10>",

  # default config file as boot
  "<wait5>",
  "<enter><wait>",

  "<wait10>",

  # reboot
  "reboot<wait>",
  "<enter><wait>",

  # confirm
  "<wait5>",
  "y<wait>",
  "<enter><wait>",

  # wait for reboot
  "<wait60>",

  # login
  "vyos<wait>",
  "<enter><wait>",
  "vyos<wait>",
  "<enter><wait>",

  # enter configuration mode
  "<wait5>",
  "configure<wait>",
  "<enter><wait>",

  # enable ssh https://docs.vyos.io/en/latest/configuration/service/ssh.html
  "<wait5>",
  "set service ssh port 22<wait>",
  "<enter><wait>",

  # make eth0 dhcp
  "<wait5>",
  "set interfaces ethernet eth0 address dhcp<wait>",
  "<enter><wait>",

  # get dns from dhcp
  "<wait5>",
  "set service dns forwarding dhcp eth0<wait>",
  "<enter><wait>",

  "<wait5>",
  "set service dns forwarding allow-from '127.0.0.0/8'<wait>",
  "<enter><wait>",

  "<wait5>",
  "set service dns forwarding listen-address '127.0.0.1'<wait>",
  "<enter><wait>",

  "<wait5>",
  "set system name-server '127.0.0.1'<wait>",
  "<enter><wait>",

  # commit configuration
  "<wait5>",
  "commit<wait>",
  "<enter><wait>",

  # save configuration
  "<wait5>",
  "save<wait>",
  "<enter><wait>",

  # exit configuration
  "<wait5>",
  "exit<wait>",
  "<enter><wait>",

  # install the guest agent
  "<wait5>",
  "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/qemu-guest-agent.sh<enter><wait>",

  "<wait5>",
  "/bin/bash qemu-guest-agent.sh<enter><wait>",

  # wait until qemu is installed
  "<wait10>",

  # cleanup
  "rm -f qemu-guest-agent.sh<enter><wait>",
  "<wait5>"
]

provisioner  = []

