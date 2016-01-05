#!/usr/bin/env bash

dir=/tmp/python

# Install Python Pip
mkdir $dir
cd $dir
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py
rm -r $dir