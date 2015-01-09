#!/usr/bin/env bash

sudo service mysql stop


sudo mkdir -p /srv/db
sudo rsync -av /var/lib/mysql /srv/db/mysql

sudo sed -i "s/datadir		= \/var\/lib\/mysql/datadir		= \/srv\/db\/mysql/" /etc/mysql/my.cnf
sudo sed -i "s/\/var\/lib\/mysql\/ r/\/srv\/db\/mysql\/ r/" /etc/apparmor.d/usr.sbin.mysqld
sudo sed -i "s/\/var\/lib\/mysql\/\*\* rwk/\/srv\/db\/mysql\/\*\* rwk/" /etc/apparmor.d/usr.sbin.mysqld
sudo /etc/init.d/apparmor reload


sudo service mysql start