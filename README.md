**Requires Packer 1.6.6+ (nightly) with Proxmox 6.2-15**

> packer validate ./ubuntu-18.04.json

> cp example-vars.json config.json

> packer build -var-file="./config.json" ./ubuntu-18.04.json