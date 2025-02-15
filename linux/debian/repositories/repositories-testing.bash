#!/bin/bash

## Install TOR transport support for apt
dpkg -s apt-transport-tor   >& /dev/null || sudo apt install --assume-yes apt-transport-tor  
## Install HTTPS ransport support for apt
dpkg -s apt-transport-https >& /dev/null || sudo apt install --assume-yes apt-transport-https 
## delete old format sources.list 
[ -f /etc/apt/sources.list ] && sudo rm -f /etc/apt/sources.list
## Generate new format (deb822) sources file in /etc/apt/sources.list.d/w
sudo \cat > /etc/apt/sources.list.d/debian.sources <<-EOF
#! Debian Repositories
Name: Debian Testing - Main
Enabled: yes
Types: deb 
URIs: https://deb.debian.org/debian/ 
Suites: testing testing-updates testing-backports
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

#! Debian Security Updates Repositories
Name: $(lsb_release -sd) - Security
Enabled: yes
Types: deb
URIs: https://security.debian.org/debian-security
Suites: testing-security
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
