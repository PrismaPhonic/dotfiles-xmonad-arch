###################
## MARIADB SETUP ##
###################

# Install and setup mariadb
sudo pacman -S --noconfirm --needed mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service

# Make MySQL installation more secure
sudo mysql_secure_installation

echo 'MariaDB is now installed and mysql_secure_installation has finished.'
echo 'It's recommended that you read the arch wiki page on MariaDB to further configure your installation.'
