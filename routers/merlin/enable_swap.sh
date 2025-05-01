#!/bin/sh

entware="/dev/sda1"
swap="/dev/sda2"

mkdir -p /tmp/entware

mkswap $swap
swapon $swap && free

script=/jffs/scripts/post-mount

[ -f "$script" ] || touch "$script"

grep -qFx "mount -t ext4 $entware /tmp/ssd" "$script" || 
  echo "mount -t ext4 $entware /tmp/ssd" >> "$script"

grep -qFx "swapon $swap" "$script" || 
  echo "swapon $swap" >> "$script"

chmod +x $script