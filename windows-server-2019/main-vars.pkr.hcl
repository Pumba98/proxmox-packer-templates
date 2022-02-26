template_name  = "windows-server-2019-template"
iso_file = "win-server-2019_x64FRE_en-us.iso"
iso_url = ""
iso_checksum = ""
disk_size = "20G"
additional_iso_files = [
    {
        device           = "sata3"
        iso_checksum     = "a90c222fc5fd872e6c71dc63d6bb3eacecb9550befc387328fa5b2bf411ecfc9"
        iso_url          = "./Autounattend.iso"
        iso_file         = ""
    },
    {
        device   = "sata4"
        iso_checksum = ""
        iso_url = ""
        iso_file = "virtio-win-0.1.185.iso"
    }
]
communicator = "winrm"
boot_command = []
provisioner = []
