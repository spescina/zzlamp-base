#!/usr/bin/env bash

SERVER_IP=$1;

# Enable the base srv document root
sudo sed -i "s/#  <Directory \/srv\/>/<Directory \/srv\/>/" /etc/apache2/apache2.conf
sudo sed -i "s/#    Options Indexes FollowSymLinks/	Options Indexes FollowSymLinks/" /etc/apache2/apache2.conf
sudo sed -i "s/#    AllowOverride None/	AllowOverride None/" /etc/apache2/apache2.conf
sudo sed -i "s/#    Require all granted/	Require all granted/" /etc/apache2/apache2.conf
sudo sed -i "s/#  <\/Directory>/<\/Directory>/" /etc/apache2/apache2.conf

# Create the example virtual host
echo "<VirtualHost *:80>" >> /etc/apache2/sites-available/zzf_example.conf
echo "    ServerAdmin admin@example.com" >> /etc/apache2/sites-available/zzf_example.conf
echo "    ServerName example.$SERVER_IP.xip.io" >> /etc/apache2/sites-available/zzf_example.conf
echo "    DocumentRoot /srv/www/example/public" >> /etc/apache2/sites-available/zzf_example.conf
echo "    ErrorLog ${APACHE_LOG_DIR}/example-error.log" >> /etc/apache2/sites-available/zzf_example.conf
echo "    CustomLog ${APACHE_LOG_DIR}/example-access.log combined" >> /etc/apache2/sites-available/zzf_example.conf
echo "    " >> /etc/apache2/sites-available/zzf_example.conf
echo "    <FilesMatch \.php$>" >> /etc/apache2/sites-available/zzf_example.conf
echo "       # Change this \"proxy:unix:/path/to/fpm.socket\"" >> /etc/apache2/sites-available/zzf_example.conf
echo "       # if using a Unix socket" >> /etc/apache2/sites-available/zzf_example.conf
echo "       SetHandler \"proxy:fcgi://127.0.0.1:9000\"" >> /etc/apache2/sites-available/zzf_example.conf
echo "    </FilesMatch>" >> /etc/apache2/sites-available/zzf_example.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/zzf_example.conf

# Enable the example virtual host
sudo a2ensite zzf_example
sudo service apache2 restart