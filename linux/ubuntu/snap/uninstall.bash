#!/bin/bash

### Remov SNAP
snap list
for snap in $(snap list | awk 'NR>1 {print $1}'); do sudo snap remove --purge "$snap"; done
for snap in $(snap list | awk 'NR>1 {print $1}'); do sudo snap remove --purge "$snap"; done
sudo systemctl stop snapd
sudo systemctl disable snapd
sudo syetemctl mask snapd
sudo apt purge snapd -y
sudp apt-mark hold snapd
sudo rm -fr ~/snap/
sudo rm -fr /snap
sudo rm -fr /var/snap
sudo rm -fr /var/lib/snap
sudo rm -rf /var/cache/snapd/
