#!/usr/bin/env bash

# Base system, Optimization ✪
sudo dpkg -s preload         >& /dev/null || sudo apt install --assume-yes preload
sudo dpkg -s zram-tools      >& /dev/null || sudo apt install --assume-yes zram-tools
sudo dpkg -s zram-config     >& /dev/null || sudo apt install --assume-yes zram-config
sudo dpkg -s intel-microcode >& /dev/null || sudo apt install --assume-yes intel-microcode
sudo dpkg -s amd64-microcode >& /dev/null || sudo apt install --assume-yes amd64-microcode
sudo dpkg -s cpufrequtils    >& /dev/null || sudo apt install --assume-yes cpufrequtils
sudo dpkg -s bleachbit       >& /dev/null || sudo apt install --assume-yes bleachbit
sudo dpkg -s stacer          >& /dev/null || sudo apt install --assume-yes stacer
sudo dpkg -s cpu-x           >& /dev/null || sudo apt install --assume-yes cpu-x

# configure zram
sudo sed -i.bak \
     -e 's/[# ]*ALGO=.*/ALGO=zstd/g' \
     -e 's/[# ]*PERCENT=.*/PERCENT=50/g' \
          /etc/default/zramswap
# configure zswap if enabled in the kernel
if ( cat /boot/config-$(uname -r) | grep -i "^CONFIG_ZSWAP=y" ); then
	{
		# enable zswap 
		echo Y > /sys/module/zswap/parameters/enabled
		sudo sed -i.bak '/^GRUB_CMDLINE_LINUX_DEFAULT="/{ /zswap\.zpool=zsmalloc/! s/^\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"$/\1 zswap.zpool=zsmalloc"/}' /etc/default/grub
		sudo sed -i.bak '/^GRUB_CMDLINE_LINUX_DEFAULT="/{ /swap\.compressor=lz4/!  s/^\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"$/\1 swap.compressor=lz4"/}'  /etc/default/grub
		# set zswap max pool percent to 40% if RAM is less than 8GB
		[ $(awk '/MemTotal/ {print $2}' /proc/meminfo) -le 8388608 ] && echo 40 > /sys/module/zswap/parameters/max_pool_percent
		sudo update-grub 
		# 
		grep -q -e 'z3fold' /etc/initramfs-tools/modules || echo 'z3fold' >> /etc/initramfs-tools/modules
		grep -q -e 'lz4' /etc/initramfs-tools/modules    || echo 'lz4' >> /etc/initramfs-tools/modules
		sudo update-initramfs -u
		sudo dmesg | grep zswap
	}
fi
#         
swapon --show
# reduce swapiness from the default 60 to 10
grep -q -e 'vm.swappiness = 10' /etc/sysctl.conf || echo 'vm.swappiness = 10' >> /etc/sysctl.conf
sudo sysctl vm.swappiness=10
# check swapiness
sudo sysctl -p