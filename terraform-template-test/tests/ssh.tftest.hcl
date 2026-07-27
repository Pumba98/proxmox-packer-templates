run "connection_test_assert" {
  command = apply

  assert {
    condition     = local.vm_ipv4_address != ""
    error_message = "The guest agent did not report a usable IPv4 address for the cloned template"
  }

  assert {
    condition     = null_resource.connection_test.id != ""
    error_message = "Connection test failed"
  }
}
