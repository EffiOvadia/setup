#!/bin/sh

DEV=/dev/sda

mkdir -p /tmp/entware

mkfs.ext4 ${DEV}1 && 
  mount -t ext4 ${DEV}1 /tmp/entware

mkswap ${DEV}2 && 
  swapon ${DEV}2

script=/jffs/scripts/post-mount

[ -f "$script" ] || touch "$script"

grep -qFx "mount -t ext4 ${DEV}1 /tmp/ssd" "$script" || 
  echo "mount -t ext4 ${DEV}1 /tmp/ssd" >> "$script"

grep -qFx "swapon ${DEV}2" "$script" || 
  echo "swapon ${DEV}2" >> "$script"

chmod +x $script