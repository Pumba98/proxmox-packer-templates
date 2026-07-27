run "template_test" {
  command = apply

  assert {
    condition     = local.vm_ipv4_address[0] != ""
    error_message = "The guest agent did not report a usable IPv4 address"
  }

  assert {
    condition     = !var.test_reboot || data.proxmox_vm.after_reboot[0].status == "running"
    error_message = "VM is not running after the reboot"
  }

  # Clones sharing a machine-id are handed the same DHCP lease.
  assert {
    condition     = !var.test_machine_id || local.vm_ipv4_address[0] != local.vm_ipv4_address[1]
    error_message = "Both clones got the same IP address, so they share a machine-id"
  }

  assert {
    condition     = !var.test_machine_id || local.vm_mac_address[0] != local.vm_mac_address[1]
    error_message = "Both clones got the same MAC address"
  }
}
