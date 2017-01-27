#!/bin/bash

# Nettoyage, au cas ou ce n est pas la premiere execution du script
echo "Nettoyage..."
apt install unzip
rm -Rf db
rm -Rf www

# Telechargement
echo "Telechargement..."
wget http://www.phpbb-fr.com/telechargements/full/phpBB-3.2.0_FR.zip

# Decompression et gestion des droits
echo "Decompression..."
unzip phpBB-3.2.0_FR.zip -d tmp
mkdir www
mkdir db
mv tmp/phpBB3/* www

# Gestion des droits
# Les fichiers sont possedes par l utilisateur de php et le groupe de nginx
# On s assure que php et nginx n aient que les droits en lecture sur les fichiers, et en exec$
# On ajoute les droits en ecriture pour php sur les dossiers cache, store, files, avatar-uplo$
# De cette maniere, other n a aucun droit

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

