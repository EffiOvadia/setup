#!/usr/bin/env bash

### Get GPG key
### sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ubnt.com/unifi/unifi-repo.gpg 

### Add Sources.list
echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/unifi.list

### update sources and install Unifi
apt update
apt install -y unifi

systemctl restart unifi
systemctl status  unifi