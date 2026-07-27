locals {
  test_username = var.windows ? var.winrm_username : var.ssh_username
  test_password = var.windows ? var.winrm_password : var.ssh_password

  vm_count = var.test_machine_id ? 2 : 1

  # Template ids are consecutive, so clones are spaced a block apart to keep
  # template N's second clone off template N+1's first.
  vm_id_offset = 1000
  vm_id_stride = 100

  # Guards against reconnecting to the still-running pre-reboot OS.
  max_post_reboot_uptime = 300

  # first non-loopback/non-APIPA address per VM
  vm_ipv4_address = {
    for idx, vm in proxmox_virtual_environment_vm.template_test :
    idx => try([
      for address in flatten(vm.ipv4_addresses) :
      address
      if !startswith(address, "127.") && !startswith(address, "169.254.")
    ][0], "")
  }

  vm_mac_address = {
    for idx, vm in proxmox_virtual_environment_vm.template_test :
    idx => lower(join(",", vm.mac_addresses))
  }
}

resource "proxmox_virtual_environment_vm" "template_test" {
  count = local.vm_count

  name      = "template-${var.template_id}-test-${count.index}"
  node_name = var.node
  pool_id   = var.pool

  vm_id = var.template_id + local.vm_id_offset + count.index * local.vm_id_stride

  clone {
    vm_id = var.template_id
  }

  agent {
    enabled = true
    timeout = var.agent_timeout
  }

  # windows templates have no cloud-init drive
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
  count = local.vm_count

  triggers = {
    vm_id = proxmox_virtual_environment_vm.template_test[count.index].id
  }

  connection {
    type     = var.windows ? "winrm" : "ssh"
    host     = local.vm_ipv4_address[count.index]
    user     = local.test_username
    password = local.test_password
    timeout  = var.connection_timeout
    insecure = true
  }

  provisioner "remote-exec" {
    inline = var.windows ? ["systeminfo | findstr /B /C:\"OS Name\""] : ["uname -a"]
  }
}

resource "null_resource" "reboot" {
  count = var.test_reboot ? 1 : 0

  depends_on = [null_resource.connection_test]

  triggers = {
    vm_id = proxmox_virtual_environment_vm.template_test[0].id
  }

  connection {
    type     = var.windows ? "winrm" : "ssh"
    host     = local.vm_ipv4_address[0]
    user     = local.test_username
    password = local.test_password
    timeout  = var.connection_timeout
    insecure = true
  }

  # Backgrounded so the command returns before the session drops.
  provisioner "remote-exec" {
    inline = var.windows ? [
      "shutdown /r /t 5",
      ] : [
      "sudo sh -c 'nohup sh -c \"sleep 5; reboot\" >/dev/null 2>&1 &'",
    ]
  }
}

# Reconnecting on the pre-reboot address is the same-IP assertion: a VM that came
# back elsewhere is never reachable here. The uptime check catches the race where
# the guest has not started shutting down yet.
resource "null_resource" "post_reboot_test" {
  count = var.test_reboot ? 1 : 0

  depends_on = [null_resource.reboot]

  triggers = {
    vm_id = proxmox_virtual_environment_vm.template_test[0].id
  }

  connection {
    type     = var.windows ? "winrm" : "ssh"
    host     = local.vm_ipv4_address[0]
    user     = local.test_username
    password = local.test_password
    timeout  = var.reboot_timeout
    insecure = true
  }

  provisioner "remote-exec" {
    inline = var.windows ? [
      "powershell -Command \"$up = ((Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime).TotalSeconds; Write-Host \\\"uptime=$up\\\"; if ($up -gt ${local.max_post_reboot_uptime}) { throw 'VM did not reboot' }\"",
      ] : [
      "up=$(cut -d. -f1 /proc/uptime); echo \"uptime=$${up}\"; [ \"$${up}\" -lt ${local.max_post_reboot_uptime} ] || { echo 'VM did not reboot'; exit 1; }",
    ]
  }
}

# A template converted without truncating /etc/machine-id hands every clone the
# same id. The cross-VM comparison is in the tftest assertions.
resource "null_resource" "machine_id_test" {
  count = var.test_machine_id && !var.windows ? local.vm_count : 0

  depends_on = [null_resource.connection_test]

  triggers = {
    vm_id = proxmox_virtual_environment_vm.template_test[count.index].id
  }

  connection {
    type     = "ssh"
    host     = local.vm_ipv4_address[count.index]
    user     = local.test_username
    password = local.test_password
    timeout  = var.connection_timeout
  }

  provisioner "remote-exec" {
    inline = ["[ -s /etc/machine-id ] || { echo 'machine-id is empty or missing'; exit 1; }"]
  }
}

data "proxmox_vm" "after_reboot" {
  count = var.test_reboot ? 1 : 0

  depends_on = [null_resource.post_reboot_test]

  node_name = var.node
  id        = proxmox_virtual_environment_vm.template_test[0].vm_id
}
