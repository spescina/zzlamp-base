#!/bin/sh
 
# Laravel installer installation
wget http://laravel.com/laravel.phar
mv laravel.phar /usr/local/bin/laravel
chmod +x /usr/local/bin/laravel
 
# NodeJs installation
apt-get install -y python
apt-get install -y g++
apt-get install -y make
apt-get install -y checkinstall
apt-get install -y fakeroot
src=$(mktemp -d) && cd $src
wget -N http://nodejs.org/dist/node-latest.tar.gz
tar xzvf node-latest.tar.gz && cd node-v*
./configure
fakeroot checkinstall -y --install=no --pkgversion $(echo $(pwd) | sed -n -re's/.+node-v(.+)$/\1/p') make -j$(($(nproc)+1)) install
dpkg -i node_*
 
# NodeJs Global Package installation
npm install -g grunt-cli gulp bower
 
# Ruby Gems installation
gem install sass
 
# Ajenti Control Panel installation
wget -O- https://raw.github.com/Eugeny/ajenti/master/scripts/install-debian.sh | sh