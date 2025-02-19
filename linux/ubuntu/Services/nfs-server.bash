#!/usr/bin/env bash

sudo apt install nfs-common nfs-kernel-server -y

grep -q -e '^/' /etc/exports && 
  sed -i.bak '/^\/ s|.*|/   192.168.0.0/16(rw,sync,no_subtree_check)|' /etc/exports || 
    echo '/   192.168.0.0/16(rw,sync,no_subtree_check)' >> /etc/exports

sudo exportfs -a
sudo systemctl enable nfs-kernel-server
sudo systemctl restart nfs-kernel-server
sudo systemctl status nfs-kernel-server
sudo exportfs -v


