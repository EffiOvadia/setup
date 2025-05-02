#!/bin/sh

DEV=/dev/sda

mountpoint=/tmp/mnt/entware
mkdir -p $mountpoint

mkswap ${DEV}2 && 
  swapon ${DEV}2

mkfs.ext4 ${DEV}1 && 
  mount -t ext4 ${DEV}1 $mountpoint

script=/jffs/scripts/post-mount

[ -f "$script" ] || touch "$script"

grep -qFx "mount -t ext4 ${DEV}1 $mountpoint" "$script" || echo "mount -t ext4 ${DEV}1 $mountpoint" >> "$script"

grep -qFx "swapon ${DEV}2" "$script" || echo "swapon ${DEV}2" >> "$script"

chmod +x $script