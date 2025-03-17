#!/usr/bin/env bash

### Remov SNAP
snap list
for snap in $(snap list | awk 'NR>1 {print $1}'); do sudo snap remove --purge "$snap"; done
for snap in $(snap list | awk 'NR>1 {print $1}'); do sudo snap remove --purge "$snap"; done


sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd
sudo apt purge snapd -y
sudo apt-mark hold snapd
sudo rm -fr ~/snap/
sudo rm -fr /snap
sudo rm -fr /var/snap
sudo rm -fr /var/lib/snap
sudo rm -rf /var/cache/snapd/

sudo \cat > /etc/apt/preferences.d/nosnap.pref <<-EOF
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF