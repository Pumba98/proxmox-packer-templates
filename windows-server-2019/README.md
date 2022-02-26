```sh
mkisofs -J -l -R -V "Label CD" -iso-level 4 -o Autounattend.iso setup 
sha256sum Autounattend.iso | awk '{print $1}'
```

Drivers: `https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.185-2/virtio-win-0.1.185.iso`