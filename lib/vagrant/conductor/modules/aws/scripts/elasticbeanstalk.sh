#!/usr/bin/env bash

# Install unzip
sudo pip install awsebcli

su vagrant <<EOF
    sudo pip install awsebcli
EOF