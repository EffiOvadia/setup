#!/bin/bash

#@ Install TOR and HTTPS transport for apt 
sudo apt install --assume-yes apt-transport-https apt-transport-tor 

#@ Generate sources.list file for Raspberry Pi 
sudo cat > /etc/apt/sources.list <<-EOF
### $(lsb_release -sd) $(lsb_release -sc)
### -------------------------------------------------------------------------------------------------------
deb [arch=$(dpkg --print-architecture)] http://ports.ubuntu.com/ubuntu-ports/ $(lsb_release -sc)           main restricted universe multiverse
deb [arch=$(dpkg --print-architecture)] http://ports.ubuntu.com/ubuntu-ports/ $(lsb_release -sc)-updates   main restricted universe multiverse
deb [arch=$(dpkg --print-architecture)] http://ports.ubuntu.com/ubuntu-ports/ $(lsb_release -sc)-security  main restricted universe multiverse
deb [arch=$(dpkg --print-architecture)] http://ports.ubuntu.com/ubuntu-ports/ $(lsb_release -sc)-backports main restricted universe multiverse
### -------------------------------------------------------------------------------------------------------
EOF
