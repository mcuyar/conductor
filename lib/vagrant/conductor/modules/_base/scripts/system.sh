#!/usr/bin/env bash

# Update Package List
apt-get update

# Upgrade System Packages
apt-get -y upgrade

# Force Locale
echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
locale-gen en_US.UTF-8

# Set Timezone
echo "America/New_York" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

# install common packages
apt-get install -y \
software-properties-common \
curl build-essential \
dos2unix \
gcc \
git \
libmcrypt4 \
libpcre3-dev \
make \
python2.7-dev \
re2c \
supervisor \
unattended-upgrades \
whois \
vim \
libnotify-bin

# Install package cloud gpg.key
curl -s https://packagecloud.io/gpg.key | apt-key add -

apt-get update

# Add vagrant user to www-data
usermod -a -G www-data vagrant
id vagrant
groups vagrant

# Enable swap memory
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1