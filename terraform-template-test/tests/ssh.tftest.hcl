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

  assert {
    condition     = !var.test_machine_id || local.vm_identity[0] != ""
    error_message = "Could not read the ssh host key / machine SID from the first clone"
  }

  # Both identities are generated per machine, so a shared value means the
  # template was not cleaned before conversion.
  assert {
    condition     = !var.test_machine_id || local.vm_identity[0] != local.vm_identity[1]
    error_message = "Both clones have the same ssh host key / machine SID, so the template was not cleaned before conversion"
  }
}
