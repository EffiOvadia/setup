#!/usr/bin/env bash

## create multiple folders and set permission 
\install -d -m 0755 -o effio -g sudo /imports/{tv,x230t,dusk,orangpi}

## example lines for /etc/fstab
#192.168.50.100:/    /imports/tv     nfs  nfsvers=4,_netdev,x-systemd.automount,nofail 0 0 # nfs
#192.168.50.50:/     /imports/x230t  nfs  nfsvers=4,_netdev,x-systemd.automount,nofail 0 0 # nfs
#192.168.50.10:/     /imports/dusk   nfs  nfsvers=4,_netdev,x-systemd.automount,nofail 0 0 # nfs
