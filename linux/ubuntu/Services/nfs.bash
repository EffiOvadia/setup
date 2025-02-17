#!/usr/bin/env bash

sudo apt install nfs-common nfs-kernel-server -y

[[ -d /home/public ]] && chmod 777 /home/public -R || mkdir -m 777 -p /home/public

grep -q -e '.*/home/public.*' /etc/exports && 
  sed -i '/\/home\/public/ s|.*|/home/public 192.168.0.0/16(rw,sync,no_subtree_check)|' /etc/exports || 
  echo '/home/public 192.168.0.0/16(rw,sync,no_subtree_check)' >> /etc/exports

sudo exportfs -a

sudo systemctl restart nfs-kernel-server
sudo systemctl enable  nfs-kernel-server

## Check Status
sudo systemctl status nfs-kernel-server
exportfs -v

[[ -d /nfs/tv ]] || mkdir /nfs/tv
echo '#192.168.50.100:/home/public   /nfs/tv   nfs   defaults 0 0' >> /etc/fstab

sed '/^\[mountd\]/,/^$/ {s/^port=.*/port=20048/; t; /port=/! a\port=20048}'  /etc/nfs.conf
