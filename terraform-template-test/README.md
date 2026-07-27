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

Test VMs are created with ID `template_id + 1000` and `template_id + 1100`, and are destroyed again when the test finishes. The two are spaced a block apart because template IDs are consecutive, so a smaller gap would make one template's second clone collide with the next template's first.

## Reboot test

The VM is rebooted from inside the guest and the test reconnects on the same IP it saw before.

## Machine id test

A second VM is cloned and the two are compared for a shared identity.

- Linux - the SSH host key, via `ssh-keyscan` in [scripts/hostkey.sh](scripts/hostkey.sh). Generated per machine on first boot.
- Windows - the machine SID (the local account SID minus its RID), via [scripts/machinesid.py](scripts/machinesid.py).

## CI

This runs automatically after every template build via the [terraform-test.yml](../.github/workflows/terraform-test.yml) workflow
