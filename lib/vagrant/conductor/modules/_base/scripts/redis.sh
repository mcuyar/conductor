#!/usr/bin/env bash

# Update Package List
apt-get update

# Add the ppa
apt-add-repository ppa:rwky/redis -y

# Update Package Lists
apt-get update

# Install Redis

apt-get install -y redis-server