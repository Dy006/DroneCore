#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get install -y git-core
git clone git://git.drogon.net/wiringPi
cd wiringPi
git pull origin
./build
apt-get install -y apache2
apt-get install -y php5 libapache2-mod-php5 php5-mcrypt
apt-get install -y mysql-server libapache2-mod-auth-mysql php5-mysql
apt-get install -y phpmyadmin
cd /var/www/html
git clone https://github.com/DGIProject/DGIPyDrOneHTML.git
service apache2 restart
apt-get install -y nodejs
apt-get install -y npm
npm install socket.io
