#!/usr/bin/env bash

home=$(sudo -u vagrant pwd)
upgrade='--upgrade'

if [ ! -d $home/.aws ]; then
    mkdir $home/.aws;
fi

if [ ! -f $home/.aws/installed ]; then
    upgrade=''
    touch $home/.aws/installed
fi

# Run the install script
pip install $upgrade awscli awsebcli