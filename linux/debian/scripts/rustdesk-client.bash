#!/usr/bin/env bash
 
# Create directories if they don't exist
sudo mkdir -p ~/.config/rustdesk
sudo mkdir -p ~/.var/app/com.rustdesk.RustDesk/config/rustdesk

# Write the configuration
sudo cat <<EOF | sudo tee ~/.var/app/com.rustdesk.RustDesk/config/rustdesk/RustDesk2.toml ~/.config/rustdesk/RustDesk2.toml
rendezvous_server = '172.232.211.116:21116'
trusted_devices = '00aLG2qnvIwvV1ja/SnjbPpQL8'
nat_type = 1
serial = 0
unlock_pin = ''

[options]
relay-server = '172.232.211.116'
custom-rendezvous-server = '172.232.211.116'
key = 'FGnqzqGE19xjRrIkoWCoLTOfKJtKh06dLYRmnzOjJRs='
verification-method = 'use-permanent-password'
auto-disconnect-timeout = '5'
allow-auto-disconnect = 'Y'
allow-linux-headless = 'Y'
access-mode = 'full'
direct-server = 'Y'
av1-test = 'Y'
EOF

[ -f /etc/gdm3/custom.conf ] && sudo sed -i 's/[# ]*WaylandEnable=.*/WaylandEnable=false/g' /etc/gdm3/custom.conf ||
  sudo printf "[daemon]\nWaylandEnable=false" | sudo tee /etc/gdm3/custom.conf >/dev/null
