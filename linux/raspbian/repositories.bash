#!/bin/bash

#@ Install TOR and HTTPS transport for apt 
sudo apt install --assume-yes apt-transport-https apt-transport-tor 

#@ delete old format sources.list 
sudo [ -f /etc/apt/sources.list ] && sudo rm -f /etc/apt/sources.list

#@ Generate new deb822 format debian.sources file in sources.list.d
sudo \cat > /etc/apt/sources.list.d/debian.sources <<-EOF
X-Repolib-Name: $(lsb_release -sd) - Main
Enabled: yes
Types: deb deb-src
URIs: https://deb.debian.org/debian/ 
Suites: $(lsb_release -sc) $(lsb_release -sc)-updates $(lsb_release -sc)-backports
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

X-Repolib-Name: $(lsb_release -sd) - Security
Enabled: yes
Types: deb deb-src
URIs: https://security.debian.org/debian-security
Suites: $(lsb_release -sc)-security
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
