#!/bin/bash

apt install -y compiz compiz-mate 
apt install -y emerald emerald-themes fusion-icon simple-ccsm
apt install -y compiz-plugins-default compiz-plugins-main compiz-plugins-extra compiz-plugins-experimental


#---------------------------------------------------------------------------
### https://compiz-debian.tuxfamily.org
wget -q http://download.tuxfamily.org/compiz/apt/key.pub -O- | apt-key add - 
cat > /etc/apt/sources.list.d/compiz-debian.list <<-EOF
deb http://download.tuxfamily.org/compiz/debian $(lsb_release -sc) main
EOF

apt update 
apt install -y compiz-reloaded
apt install -y emerald emerald-themes fusion-icon 
apt install -y compiz-reloaded-mate simple-ccsm-reloaded 
apt install -y compiz-reloaded-plugins-extra compiz-reloaded-plugins-experimental
