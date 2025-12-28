#!/bin/bash

set -x
set -e

# vyos-2025.12.23-0021 is still "bookworm" - you might have to change this later

echo "deb http://deb.debian.org/debian bookworm main contrib non-free" | sudo tee /etc/apt/sources.list.d/debian_temp.list

sudo apt-get update
sudo apt-get install -y qemu-guest-agent

sudo systemctl enable --now qemu-guest-agent

sudo rm /etc/apt/sources.list.d/debian_temp.list
sudo apt-get update
