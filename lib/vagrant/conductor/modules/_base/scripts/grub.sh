#!/usr/bin/env bash

# Update Grub Bootloader
echo "set grub-pc/install_devices /dev/sda" | debconf-communicate
apt-get -y remove grub-pc
apt-get -y install grub-pc
grub-install /dev/sda
update-grub

export DEBIAN_FRONTEND=noninteractive