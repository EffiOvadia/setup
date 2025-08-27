#!/usr/bin/env bash
 
# create a tap0 interface for openvpn
sudo cat <<EOF | sudo tee /etc/systemd/network/99-tap0.network
[Match]
Name=tap0

[Network]
DHCP=yes
EOF

sudo systemctl restart systemd-networkd

