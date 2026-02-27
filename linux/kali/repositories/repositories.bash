#!/usr/bin/env bash

# Install TOR transport support for apt
sudo dpkg -s apt-transport-tor   >& /dev/null || sudo apt install --assume-yes apt-transport-tor  
# Install HTTPS ransport support for apt
sudo dpkg -s apt-transport-https >& /dev/null || sudo apt install --assume-yes apt-transport-https 
# delete old format sources.list 
[ -f /etc/apt/sources.list ] && sudo rm -f /etc/apt/sources.list
# Generate new format (deb822) sources file in /etc/apt/sources.list.d/
sudo \cat > /etc/apt/sources.list.d/kali.sources <<-EOF
#! Kali Repositories
Name: $(lsb_release -sd)
Enabled: yes
Types: deb
URIs: https://http.kali.org/kali
Suites: $(lsb_release -sc)
Components: main contrib non-free non-free-firmware 
Architectures: $(dpkg --print-architecture)
Signed-By: 
EOF
# download and install the Kali archive keyring
sudo wget https://archive.kali.org/archive-keyring.gpg -O /usr/share/keyrings/kali-archive-keyring.gpg