locals {
  test_username = var.windows ? var.winrm_username : var.ssh_username
  test_password = var.windows ? var.winrm_password : var.ssh_password

  # pick the first non-loopback/non-APIPA address
  vm_ipv4_addresses = [
    for address in flatten(proxmox_virtual_environment_vm.template_test.ipv4_addresses) :
    address
    if !startswith(address, "127.") && !startswith(address, "169.254.")
  ]

  vm_ipv4_address = length(local.vm_ipv4_addresses) > 0 ? local.vm_ipv4_addresses[0] : ""
}

resource "proxmox_virtual_environment_vm" "template_test" {
  name      = "template-${var.template_id}-test"
  node_name = var.node

  vm_id = var.template_id + 1000

  pool_id = var.pool

  clone {
    vm_id = var.template_id
  }

  agent {
    enabled = true
    timeout = var.agent_timeout
  }

  # no cloud-init drive for windows templates
  dynamic "initialization" {
    for_each = var.windows ? [] : [1]

    content {
      datastore_id = var.cloud_init_storage_pool

      ip_config {
        ipv4 {
          address = "dhcp"
        }
      }

      user_account {
        username = local.test_username
        password = local.test_password
      }
    }
  }
}

resource "null_resource" "connection_test" {
  depends_on = [proxmox_virtual_environment_vm.template_test]

  triggers = {
    vm_id = proxmox_virtual_environment_vm.template_test.id
  }

  connection {
    type     = var.windows ? "winrm" : "ssh"
    host     = local.vm_ipv4_address
    user     = local.test_username
    password = local.test_password
    timeout  = var.connection_timeout

    # Ignored for ssh connections.
    https    = false
    insecure = true
    use_ntlm = false
  }

  provisioner "remote-exec" {
    inline = var.windows ? [
      "echo WinRM OK",
      "systeminfo | findstr /B /C:\"OS Name\" /C:\"OS Version\"",
      ] : [
      "echo SSH OK",
      "uname -a",
    ]
  }
}
