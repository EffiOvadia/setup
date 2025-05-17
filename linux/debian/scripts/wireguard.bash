#!/usr/bin/env bash

# install WireGuard
sudo dpkg -s wireguard >/dev/null 2>&1       || sudo apt install -y wireguard
sudo dpkg -s wireguard-tools >/dev/null 2>&1 || sudo apt install -y wireguard-tools

# Generate Wireguard Keys
umask 077
wg genkey | tee /etc/wireguard/server_private.key | wg pubkey > /etc/wireguard/server_public.key

# Configure WireGuard
sudo tee /etc/wireguard/wg0.conf > /dev/null <<-EOF
[Interface]
Address = 10.6.0.1/24
ListenPort = 51820
PrivateKey = $(cat /etc/wireguard/server_private.key)
SaveConfig = true

EOF
 
# Enable IP forwarding and make it persistent
sudo sysctl -w net.ipv4.ip_forward=1
grep -q "^net.ipv4.ip_forward=1" /etc/sysctl.conf || echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf

# Detect default network interface
Interface=$(ip route get 1.1.1.1 | awk '{for(i=1;i<=NF;i++) if ($i=="dev") {print $(i+1); exit}}')

# NAT block to add (/etc/ufw/before.rules)
grep -q "NAT table for WireGuard" /etc/ufw/before.rules || \
  sudo sed -i.bak "1i# NAT table for WireGuard\n*nat\n:POSTROUTING ACCEPT [0:0]\n-A POSTROUTING -s 10.6.0.0/24 -o $Interface -j MASQUERADE\nCOMMIT\n" \
    /etc/ufw/before.rules

# Create UFW rule file for Wireguard
cat > /etc/ufw/applications.d/wireguard <<-'EOF'
[WireGuard]
title=WireGuard VPN Server
description=WireGuard Server 
ports=51820/udp
EOF

# Allow WireGuard port 
sudo ufw allow from any to 0.0.0.0/0 app WireGuard comment "WireGuard"

# Reload UFW
sudo ufw disable && sudo ufw enable
