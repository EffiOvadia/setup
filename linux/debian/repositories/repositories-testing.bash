#!/bin/bash

## Install TOR transport support for apt
dpkg -s apt-transport-tor >& /dev/null || sudo apt install --assume-yes apt-transport-tor  
## Install HTTPS ransport support for apt
dpkg -s apt-transport-https >& /dev/null || sudo apt install --assume-yes apt-transport-https 
## delete old format sources.list 
sudo [ -f /etc/apt/sources.list ] && sudo rm -f /etc/apt/sources.list
## Generate new format (deb822) sources file in /etc/apt/sources.list.d/w
sudo \cat > /etc/apt/sources.list.d/debian.sources <<-EOF
X-Repolib-Name: Debian Testing - Main
Enabled: yes
Types: deb deb-src
URIs: https://deb.debian.org/debian/ 
Suites: testing testing-updates testing-backports
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

X-Repolib-Name: Debian Testing - Securitry 
Enabled: yes
Types: deb deb-src
URIs: https://security.debian.org/debian-security
Suites: testing-security
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
