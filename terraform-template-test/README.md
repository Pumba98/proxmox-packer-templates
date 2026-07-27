# Template Tests

Terraform test that clones a packer-built template and verifies the resulting VM actually boots and is reachable.

For Linux templates it verifies cloud-init provisions a user and the VM is reachable over SSH. Windows templates are built with `cloud_init = false`, so they are cloned without a cloud-init drive and verified over WinRM using the credentials packer baked into the image.

Run it against a Linux template:

```sh
terraform init
TF_VAR_template_id=1020 terraform test
```

Run it against a Windows template:

```sh
TF_VAR_template_id=1021 TF_VAR_windows=true terraform test
```

The test VM is created with ID `template_id + 1000` and is destroyed again when the test finishes.

## CI

This runs automatically after every template build via the [terraform-test.yml](../.github/workflows/terraform-test.yml) workflow
