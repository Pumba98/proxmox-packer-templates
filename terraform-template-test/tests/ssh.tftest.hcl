run "ssh_test_assert" {
  command = apply

  assert {
    condition     = null_resource.ssh_test.id != ""
    error_message = "SSH test failed"
  }
}
