#!/usr/bin/env bash

apt-get --assume-yes install unattended-upgrades
apt-get --assume-yes install zfsutils-linux zfs-initramfs
apt-get --assume-yes install f2fs-tools ntfs-3g libfsntfs-utils btrfs-progs dosfstools e2fsck-static exfat-utils xfsprogs hfsutils hfsprogs jfsutils reiser4progs exfat-utils lvm2 udftools
apt-get --assume-yes install gpart gddrescue ddrescueview myrescue safecopy testdisk scalpel foremost ddrutility disktype clonezilla chntpw hdparm
apt-get --assume-yes install ksh fish tcsh tmux vim screen mc lfm htop dnstop iftop iotop mtr

