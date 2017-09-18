############## LASAC Portal Installation ###############

# LAMP
sudo apt-get install mysql-server
sudo apt-get install php5
sudo apt-get install php5-mysql
mysql_secure_installation

# PHP MyAdmin
sudo apt-get install phpmyadmin
sudo nano /etc/apache2/apache2.conf
# Add the following line in the and of the file (uncommented):
#Include /etc/phpmyadmin/apache.conf

# both php5-mysql and phpmyadmin packages requires apache2 restart
sudo service apache2 restart

# create db
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS \`lasac\` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_unicode_ci"

# restore backup:
mysql -h localhost -u root -p lasac < ~/lasac/portal.bak.sql
