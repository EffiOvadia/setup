#!/bin/bash

## Install TOR transport support for apt
dpkg -s apt-transport-tor >& /dev/null || sudo apt install --assume-yes apt-transport-tor  
## Install HTTPS ransport support for apt
dpkg -s apt-transport-https >& /dev/null || sudo apt install --assume-yes apt-transport-https 
## delete old format sources.list 
sudo [ -f /etc/apt/sources.list ] && sudo rm -f /etc/apt/sources.list
## Generate new format (deb822) sources file in /etc/apt/sources.list.d/
sudo \cat > /etc/apt/sources.list.d/debian.sources <<-EOF
#! Debian Repositories
X-Repolib-Name: $(lsb_release -sd) - Main
Enabled: yes
Types: deb 
URIs: http://deb.debian.org/debian/ 
Suites: $(lsb_release -sc) $(lsb_release -sc)-updates $(lsb_release -sc)-backports
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

#! Debian Security Updates Repositories
X-Repolib-Name: $(lsb_release -sd) - Security
Enabled: yes
Types: deb 
URIs: http://security.debian.org/debian-security
Suites: $(lsb_release -sc)-security
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
