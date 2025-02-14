#!/bin/bash

#@ Install TOR and HTTPS transport for apt 
sudo apt install --assume-yes apt-transport-https apt-transport-tor 

#@ Generate sources.list file for stable version
sudo \cat > /etc/apt/sources.list <<-EOF
### $(lsb_release -sd) $(lsb_release -sc)
### -------------------------------------------------------------------------------------------------------------------
deb [arch=$(dpkg --print-architecture)] https://deb.debian.org/debian/              $(lsb_release -sc)           main contrib non-free non-free-firmware 
deb [arch=$(dpkg --print-architecture)] https://deb.debian.org/debian/              $(lsb_release -sc)-updates   main contrib non-free non-free-firmware 
deb [arch=$(dpkg --print-architecture)] https://deb.debian.org/debian/              $(lsb_release -sc)-backports main contrib non-free non-free-firmware
deb [arch=$(dpkg --print-architecture)] https://security.debian.org/debian-security $(lsb_release -sc)-security  main contrib non-free non-free-firmware
### -------------------------------------------------------------------------------------------------------------------
EOF
