#!/bin/bash

#@ Install TOR and HTTPS transport for apt 
sudo apt install --assume-yes apt-transport-https apt-transport-tor 

#@ delete old format sources.list 
[ -f /etc/apt/sources.list ] && rm -f /etc/apt/sources.list

#@ create new deb822 format ubuntu.sources file in sources.list.d
sudo cat > /etc/apt/sources.list.d/ubuntu.sources <<-EOF
X-Repolib-Name: $(lsb_release -sd) $(lsb_release -sc)
Enabled: yes
Types: deb deb-src
URIs: http://ports.ubuntu.com/ubuntu-ports/ 
Suites: $(lsb_release -sc) $(lsb_release -sc)-updates $(lsb_release -sc)-backports $(lsb_release -sc)-security
Components: main restricted universe multiverse
Architectures: $(dpkg --print-architecture)
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF
