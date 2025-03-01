#!/usr/bin/env bash

#@ Install TOR transport support for apt
dpkg -s apt-transport-tor >& /dev/null || sudo apt install --assume-yes apt-transport-tor  
#@ Install HTTPS ransport support for apt
dpkg -s apt-transport-https >& /dev/null || sudo apt install --assume-yes apt-transport-https 
#@ delete old format sources.list 
sudo [ -f /etc/apt/sources.list ] && sudo rm -f /etc/apt/sources.list
#@ Generate new format (deb822) sources file in /etc/apt/sources.list.d/
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
 -----BEGIN PGP PUBLIC KEY BLOCK-----
 .
 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
 Zir+7ip/Z+S+AZmf6ExI
 =71lK
 -----END PGP PUBLIC KEY BLOCK-----
EOF
