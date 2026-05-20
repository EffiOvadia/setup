#!/usr/bin/env bash
 
sudo apt-get update && sudo apt-get install -y curl jq ca-certificates 
url=$(curl -fsSL https://api.github.com/repos/rustdesk/rustdesk/releases/latest | jq -r '.assets[] | select(.name | test("x86_64\\.deb$")) | .browser_download_url' | head -n1) 
curl -fL "$url" -o /tmp/rustdesk-latest.deb 
sudo apt install -y /tmp/rustdesk-latest.deb
sudo systemctl enable --now rustdesk

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
