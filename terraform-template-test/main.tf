resource "proxmox_virtual_environment_vm" "template_test" {
  name      = "template-${var.template_id}-test"
  node_name = "proxmox"

  vm_id = var.template_id + 1000

  pool_id = "Development"

  clone {
    vm_id = var.template_id
  }

  agent {
    enabled = true
    timeout = "2m"
  }

  initialization {
    datastore_id = "local"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = "template"
      password = "test"
    }
  }
}

resource "null_resource" "ssh_test" {
  depends_on = [proxmox_virtual_environment_vm.template_test]

  connection {
    type        = "ssh"
    host        = proxmox_virtual_environment_vm.template_test.ipv4_addresses[1][0]
    user        = "template"
    password    = "test"
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo SSH OK",
      "uname -a"
    ]
  }
}
