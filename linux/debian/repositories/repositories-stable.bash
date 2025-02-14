#!/bin/bash

## Install TOR transport support for apt
dpkg -s apt-transport-tor >& /dev/null || sudo apt install --assume-yes apt-transport-tor  
## Install HTTPS ransport support for apt
dpkg -s apt-transport-https >& /dev/null || sudo apt install --assume-yes apt-transport-https 
## delete old format sources.list 
sudo [ -f /etc/apt/sources.list ] && sudo rm -f /etc/apt/sources.list
## Generate new format (deb822) sources file in /etc/apt/sources.list.d/
sudo \cat > /etc/apt/sources.list.d/debian.sources <<-EOF
X-Repolib-Name: Debian Stable - Main
Enabled: yes
Types: deb
URIs: https://deb.debian.org/debian/ http://cdn-fastly.deb.debian.org/debian/
Suites: stable stable-updates stable-proposed-updates stable-backports
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

X-Repolib-Name: Debian Stable - Security
Enabled: yes
Types: deb
URIs: https://security.debian.org/debian-security
Suites: stable-security
Components: main contrib non-free non-free-firmware
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF