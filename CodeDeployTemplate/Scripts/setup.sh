#!/bin/bash

#Update repo, add yarn's repo
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add
grep -P 'main&precise-updates' /etc/apt/sources.list

#Download Node 8.9.0
URL='https://deb.nodesource.com/node_8.x/pool/main/n/nodejs/nodejs_8.9.0-1nodesource1_amd64.deb';
FILE=`mktemp`;
wget "$URL" -qO $FILE && sudo dpkg -i $FILE;
rm $FILE

#Install system packages and setup SSH key to clone our Git Repo
sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -f -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get -y install wget python build-essential git curl graphicsmagick ghostscript imagemagick
sudo npm install -g pm2

#Create Swap file to allow Webpack to hog obscene amounts of memory
sudo dd if=/dev/zero of=/var/swapfile bs=1M count=4096 &&
sudo chmod 600 /var/swapfile &&
sudo mkswap /var/swapfile &&
echo /var/swapfile none swap defaults 0 0 | sudo tee -a /etc/fstab &&
sudo swapon -a
