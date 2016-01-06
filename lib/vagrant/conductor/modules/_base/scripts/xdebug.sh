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

# Cleanup
cd /tmp
rm -rf xdebug

# Generate Config
php_dir="/etc/php/7.0"
ini="$php_dir/mods-available/xdebug.ini"

if [ ! -f $ini ]; then touch $ini; fi

echo "zend_extension = /usr/lib/php/20151012/xdebug.so" > $ini

ln -fs $ini "$php_dir/fpm/conf.d/20-xdebug.ini"

service php7.0-fpm restart