#!/usr/bin/env bash

# Base system, Optimization ✪
sudo dpkg -s preload     >& /dev/null || sudo apt install --assume-yes preload
sudo dpkg -s zram-tools  >& /dev/null || sudo apt install --assume-yes zram-tools
sudo dpkg -s zram-config >& /dev/null || sudo apt install --assume-yes zram-config

# configure zram
sudo sed -i.bak \
     -e 's/[# ]*ALGO=.*/ALGO=zstd/g' \
     -e 's/[# ]*PERCENT=.*/PERCENT=50/g' \
          /etc/default/zramswap
# check zram          
swapon --show
# reduce swapiness from the default 60 to 10
grep -q -e 'vm.swappiness = 10' /etc/sysctl.conf || echo 'vm.swappiness = 10' >> /etc/sysctl.conf
sudo sysctl vm.swappiness=10
# check swapiness
sudo sysctl -p
