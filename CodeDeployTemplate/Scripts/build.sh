#!/bin/bash

#Setup SSH key to clone our Git Repo
sudo chown -R ubuntu:ubuntu $HOME
cd "$(dirname "$0")"
cp $HOME/deploy_key.pem $HOME/.ssh/id_rsa
chmod 400 $HOME/.ssh/id_rsa

#Trust github.com and clone the repo
ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts
cd $HOME && git clone git@github.com:altitudelabs/champsys.git
#cd $HOME/champsys && git fetch --all && git checkout aws-integration
wget -q -O - http://169.254.169.254/latest/meta-data/instance-id > $HOME/instance-details

cd $HOME/champsys && time npm install && time npm run build-prod
