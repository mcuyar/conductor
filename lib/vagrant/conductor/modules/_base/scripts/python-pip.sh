#!/usr/bin/env bash

apt-get remove -y python-pip
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py

#pip install requests[security]