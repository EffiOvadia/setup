#!/bin/bash

### Preload
apt install -y preload
### check swapiness
cat /proc/sys/vm/swappiness
### reduce swapiness from the default 60 to 10
sudo sysctl vm.swappiness=10
grep -q -e 'vm.swappiness = 10' /etc/sysctl.conf || echo 'vm.swappiness = 10' >> /etc/sysctl.conf
sudo sysctl -p


sudo sysctl vm.page-cluster=16 # for swap on NVME or Optane
grep -q -e 'vm.page-cluster = 16' /etc/sysctl.conf || echo 'vm.page-cluster=16' >> /etc/sysctl.conf

sudo sysctl vm.vfs_cache_pressure=50
grep -q -e 'vm.vfs_cache_pressure = 50' /etc/sysctl.conf || echo 'vm.vfs_cache_pressure = 50' >> /etc/sysctl.conf

