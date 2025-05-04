#!/usr/bin/env bash

sudo dpkg -s gnutls-bin >& /dev/null || sudo apt install -y gnutls-bin
cat > /etc/systemd/resolved.conf <<-'EOF'
[Resolve]
#DNS=2606:4700:4700::1112 2606:4700:4700::1002 1.1.1.2 1.0.0.2     # Cloudflare
#DNS=2001:4860:4860::8888 2001:4860:4860::8844 8.8.8.8 8.8.4.4     # Google
DNS=2620:fe::11 2620:fe::fe:11 9.9.9.11 149.112.112.11             # Quad9
#DNS=2620:119:35::35 2620:119:53::53 208.67.222.222 208.67.220.220 # OpenDNS
#DNS=2a10:50c0::ad1:ff 2a10:50c0::ad2:ff 94.140.14.14 94.140.15.15 # AdGuard
#DNS=2a07:a8c0::7e:d392 2a07:a8c1::7e:d392 45.90.28.0 45.90.30.0   # NextDNS
#DNS=2a0d:2a00:1::2 2a0d:2a00:2::2 185.228.168.9 185.228.169.9     # CleanBrowsing
#DNS=2606:1a40::2 2606:1a40:1::2 76.76.2.2 76.76.10.2              # ControlD
DNSSEC=allow-downgrade
DNSOverTLS=yes
Domains=~.
Cache=yes
CacheFromLocalhost=no
DNSStubListener=yes
#DNSStubListenerExtra=127.0.0.1 ::1
#ResolveUnicastSingleLabel=no
StaleRetentionSec=600
ReadEtcHosts=yes
#MulticastDNS=no
#LLMNR=no
EOF

# Restart systemd-resolved to apply the new DNS configuration
systemctl restart systemd-resolved
# Display the current status of systemd-resolved
resolvectl status | awk '/Global/,/^$/'
resolvectl statistics
# Test DNS resolution
gnutls-cli --tofu -p 853 9.9.9.9