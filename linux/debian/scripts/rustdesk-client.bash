#!/usr/bin/env bash

# Create directories if they don't exist
sudo mkdir -p ~/.config/rustdesk
sudo mkdir -p ~/.var/app/com.rustdesk.RustDesk/config/rustdesk

# Write the configuration
sudo cat <<EOF | sudo tee ~/.var/app/com.rustdesk.RustDesk/config/rustdesk/RustDesk2.toml ~/.config/rustdesk/RustDesk2.toml
rendezvous_server = 'ovadia.asuscomm.com:21116'
trusted_devices = '00n6yV65Lo+OmUjZGdaoti+Vlg'
nat_type = 1
serial = 0
unlock_pin = ''

[options]
av1-test = 'Y'
direct-server = 'Y'
access-mode = 'full'
allow-auto-disconnect = 'Y'
auto-disconnect-timeout = '10'
relay-server = 'ovadia.asuscomm.com'
custom-rendezvous-server = 'ovadia.asuscomm.com'
key = 'tlGkA0LPFeA3yMD4Y5FXLEMYnJOkLImW4UdiFtnUanQ='
verification-method = 'use-permanent-password'
allow-remove-wallpaper = 'Y'
allow-linux-headless = 'Y'
EOF

[ -f /etc/gdm3/custom.conf ] && sudo sed -i 's/[# ]*WaylandEnable=.*/WaylandEnable=false/g' /etc/gdm3/custom.conf ||
  sudo printf "[daemon]\nWaylandEnable=false" | sudo tee /etc/gdm3/custom.conf >/dev/null
