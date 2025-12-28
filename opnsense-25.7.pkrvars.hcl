# renovate: datasource=custom.opnsenseRelease
name           = "opnsense-25.7-template"
iso_file       = "OPNsense-25.7-dvd-amd64.iso"
iso_url        = "https://pkg.opnsense.org/releases/25.7/OPNsense-25.7-dvd-amd64.iso.bz2"
iso_checksum   = "file:https://pkg.opnsense.org/releases/25.7/OPNsense-25.7-checksums-amd64.sha256"
disk_size      = "16G" # minimum
memory         = 4096  # minimum

iso_download_pve = false # not compatible with bz2

# default credentials - change this after installation
ssh_username   = "root"
ssh_password   = "opnsense"

cloud_init = false

#################################################
#
# - single nic
# - make it the WAN device getting an IP via DHCP (usually it is LAN with a static 192.168.1.1)
# - install opnsense-cli for updating the config.xml
# - ssh is enable at boot time (root login, password) via config.xml
# - firewall is **DISABLED** at boot time via config.xml
#

boot_wait      = "120s" # 60s, 90s, 120s (change this if needed)
boot_command   = [
  # login as installer
  "installer<wait>",
  "<enter><wait>",
  "opnsense<wait>",
  "<enter><wait>",

  # dialog for keyboard
  "<wait5>",
  "<enter><wait>",

  # choose (default) zfs installer
  "<wait5>",
  "<enter><wait>",
  # disk probe
  "<wait30>",
  # select default stripe
  "<enter><wait>",
  # select the only disk
  "<wait5>",
  "<spacebar><wait>",
  "<enter><wait>",

  # confirm with yes
  "y<wait>",
  # wait for cloning to hard disk (change this if needed)
  "<wait300>",

  # complete the installation
  "c<wait>",
  "<enter><wait>",
  # reboot
  "<wait5>",
  "r<wait>",
  "<enter><wait>",

  # wait for boot (change this if needed)
  "<wait180>",

  # login after install
  "root<wait>",
  "<enter><wait>",
  "opnsense<wait>",
  "<enter><wait>",

  # assign interface
  "<wait5>",
  "1<wait>",
  "<enter><wait>",

  # NO for LAGG
  "<wait5>",
  "<wait>",
  "<enter><wait>",

  # NO for VLAN
  "<wait5>",
  "<wait>",
  "<enter><wait>",

  # WAN interface name
  "<wait5>",
  "vtnet0<wait>",
  "<enter><wait>",

  # none
  "<wait5>",
  "<enter><wait>",

  # none
  "<wait5>",
  "<enter><wait>",

  # confirm
  "<wait5>",
  "y<wait>",
  "<enter><wait>",

  # wait to finish
  "<wait20>",

  # shell login
  "8<wait>",
  "<enter><wait>",

  # install opnsense-cli (this helps editing the config.xml)
  # https://github.com/mihakralj/opnsense-cli
  "<wait5>",
  "pkg add https://github.com/mihakralj/opnsense-cli/releases/download/0.14.0/opnsense-cli-0.14.0.pkg<wait>",
  "<enter><wait>",

  # start + setup ssh
  "<wait5>",
  "service openssh onestart<wait>",
  "<enter><wait>",

  # enable at boot time
  # <opnsense><system>
  #     <ssh>
  #       <enabled>enabled</enabled>
  #       <passwordauth>1</passwordauth>
  #       <permitrootlogin>1</permitrootlogin>
  #     </ssh>
  "<wait5>",
  "opnsense set system/ssh/enabled enabled && opnsense set system/ssh/passwordauth 1 && opnsense set system/ssh/permitrootlogin 1<wait>",
  "<enter><wait>",

  # install os-qemu-guest-agent
  "<wait5>",
  "pkg install -y os-qemu-guest-agent<wait>",
  "<enter><wait>",

  # enable at boot time
  "<wait5>",
  "sysrc qemu_guest_agent_enable=\"YES\"<wait>",
  "<enter><wait>",

  # start guest agent now (ignore error)
  "<wait5>",
  "service qemu-guest-agent start<wait>",
  "<enter><wait>",

  # disable the firewall at boot
  # <opnsense><system>
  #   <disablefilter>yes</disablefilter>
  "<wait5>",
  "opnsense set system/disablefilter yes<wait>",
  "<enter><wait>",

  # commit config.xml changes (ignore error)
  "<wait5>",
  "yes | opnsense commit || true<wait>",
  "<enter><wait>",

  # temp disable the firewall (this terminates packer)
  "<wait5>",
  "pfctl -d<wait>",
  "<enter><wait>"
]

provisioner    = []
