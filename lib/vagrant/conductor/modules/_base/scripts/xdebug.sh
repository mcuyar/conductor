#!/usr/bin/env bash

# Install
wget xdebug.org/files/xdebug-2.4.0rc3.tgz -P /tmp/xdebug
cd /tmp/xdebug
tar -xvzf xdebug-2.4.0rc3.tgz
cd /tmp/xdebug/xdebug-2.4.0RC3
phpize
./configure
make
cp modules/xdebug.so /usr/lib/php/20151012

echo "zend_extension = /usr/lib/php/20151012/xdebug.so" >> '/etc/php/7.0/cli/php.ini'

# Configure
config='/etc/php/7.0/fpm/conf.d/20-xdebug.ini'
touch $config

echo "xdebug.remote_enable = 1" >> $config
echo "xdebug.remote_connect_back = 1" >> $config
echo "xdebug.remote_port = 9000" >> $config
echo "xdebug.max_nesting_level = 512" >> $config