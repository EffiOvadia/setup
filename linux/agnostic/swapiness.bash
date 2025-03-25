#!/bin/bash

sudo sysctl vm.page-cluster=16 # for swap on NVME or Optane
grep -q -e 'vm.page-cluster = 16' /etc/sysctl.conf || echo 'vm.page-cluster=16' >> /etc/sysctl.conf

sudo sysctl vm.vfs_cache_pressure=50
grep -q -e 'vm.vfs_cache_pressure = 50' /etc/sysctl.conf || echo 'vm.vfs_cache_pressure = 50' >> /etc/sysctl.conf

sudo sysctl -p