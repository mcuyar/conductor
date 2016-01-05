#!/usr/bin/env bash

# Update Package List
apt-get update

curl --silent --location https://deb.nodesource.com/setup_5.x | bash -

# Update Package Lists
apt-get update

# Install Node
apt-get install -y nodejs
/usr/bin/npm install -g gulp
/usr/bin/npm install -g bower