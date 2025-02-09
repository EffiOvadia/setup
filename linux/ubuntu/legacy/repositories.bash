#!/bin/bash

#@ Install TOR and HTTPS transport for apt 
sudo apt install --assume-yes apt-transport-https apt-transport-tor 

#@ Generate sources.list file for stable version
sudo \cat > /etc/apt/sources.list <<-EOF
### $(lsb_release -sd) $(lsb_release -sc)
### -----------------------------------------------------------------------------------------------------
deb [arch=$(dpkg --print-architecture)] http://us.archive.ubuntu.com/ubuntu $(lsb_release -sc)           main restricted universe multiverse
deb [arch=$(dpkg --print-architecture)] http://us.archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates   main restricted universe multiverse
deb [arch=$(dpkg --print-architecture)] http://us.archive.ubuntu.com/ubuntu $(lsb_release -sc)-backports main restricted universe multiverse
deb [arch=$(dpkg --print-architecture)] http://security.ubuntu.com/ubuntu   $(lsb_release -sc)-security  main restricted universe multiverse
### -----------------------------------------------------------------------------------------------------
EOF
#@ switch repository in sources file to china
# sudo \sed -i 's/http:\/\/..\./http:\/\/cn\./g' /etc/apt/sources.list
