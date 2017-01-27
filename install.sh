#!/bin/bash

# Cleanup and pre-install
echo "Cleanup..."
apt install unzip
rm -Rf db
rm -Rf www

# Download
echo "Download..."
wget http://www.phpbb-fr.com/telechargements/full/phpBB-3.2.0_FR.zip

# Unzip
echo "Unzip..."
unzip phpBB-3.2.0_FR.zip -d tmp
mkdir www
mkdir db
mv tmp/phpBB3/* www

# Right permissions

chown -R 901:902 www

find ./www/ -type d -exec chmod 550 {} +
find ./www/ -type f -exec chmod 440 {} +

chmod -R u+w ./www/cache
chmod -R u+w ./www/store
chmod -R u+w ./www/files
chmod u+w ./www/config.php
chmod -R u+w ./www/images/avatars/upload

# Cleanup
rm -Rf tmp
rm phpBB-3.2.0_FR.zip
