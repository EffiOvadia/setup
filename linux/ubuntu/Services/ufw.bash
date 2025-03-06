#!/usr/bin/env bash

# Uncomplicated Firewall (UFW) is a program for managing a netfilter firewall designed to be easy to use.
sudo apt install -y ufw
# remove old firewall rules templates
[ -f /etc/ufw/applications.d/dns       ] && sudo rm /etc/ufw/applications.d/dns
[ -f /etc/ufw/applications.d/openssh   ] && sudo rm /etc/ufw/applications.d/openssh
[ -f /etc/ufw/applications.d/samba     ] && sudo rm /etc/ufw/applications.d/samba
[ -f /etc/ufw/applications.d/wireguard ] && sudo rm /etc/ufw/applications.d/wireguard
[ -f /etc/ufw/applications.d/unifi     ] && sudo rm /etc/ufw/applications.d/unifi
[ -f /etc/ufw/applications.d/nfs       ] && sudo rm /etc/ufw/applications.d/nfs
[ -f /etc/ufw/applications.d/dns       ] && sudo rm /etc/ufw/applications.d/dns
# create newq firewall rules templates
sudo cat > /etc/ufw/applications.d/dns <<-'EOF'
[DNS]
title=Domain Name Resolution Service
description=Port 53/udp
ports=53/udp
EOF
sudo cat > /etc/ufw/applications.d/openvpn <<-'EOF'
[OpenSSH]
title=Secure shell server, an rshd replacement
description=OpenSSH is a free implementation of the Secure Shell protocol.
ports=22/tcp
EOF
sudo cat > /etc/ufw/applications.d/samba <<-'EOF'
[OpenVPN]
title=OpenVPN server
description=OpenVPN
ports=1194/udp
EOF
cat > /etc/ufw/applications.d/wireguard <<-'EOF'
[Samba]
title=LanManager-like file and printer server for Unix
description=The Samba software suite is a collection of programs that implements the SMB/CIFS protocol for unix systems, allowing you to serve files and printers to Windows, NT, OS/2 and DOS clients. This protocol is sometimes also referred to as the LanManager or NetBIOS protocol.
ports=137,138/udp|139,445/tcp
EOF
cat > /etc/ufw/applications.d/unifi <<-'EOF'
[WireGuard]
title=WireGuard VPN Server
description=WireGuard Server 
ports=51820/udp
EOF
cat > /etc/ufw/applications.d/nfs <<-'EOF'
[UniFi]
title=Ubiquiti Networks - UniFi Controller Server
description=UniFi Controller for AccessPoints, Switches and Other UniFi products
ports=3478,10001,1900,5656:5699/udp|8080,8443,8880,8843,6789,27117/tcp
EOF
sudo cat > /etc/ufw/applications.d/nfs <<-'EOF'
[NFSv4]
title=Network File System version 4
description=NFSv4 allows a system to share directories and files with others over a network using TCP port 2049.
ports=2049/tcp
EOF
# reset and configure firewall
sudo ufw reset
sudo ufw disable
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw app update all 
sudo ufw allow from any to 0.0.0.0/0 app  DNS       comment "DNS"
sudo ufw allow from any to 0.0.0.0/0 app  NFSv4     comment "NFSv4"
sudo ufw allow from any to 0.0.0.0/0 app  Samba     comment "Samba"
sudo ufw allow from any to 0.0.0.0/0 app  OpenSSH   comment "OpenSSH"
sudo ufw allow from any to 0.0.0.0/0 app  OpenVPN   comment "OpenVPN"
sudo ufw allow from any to 0.0.0.0/0 app  WireGuard comment "WireGuard"
sudo ufw allow from any to 0.0.0.0/0 app  UniFi     comment "UniFi"
sudo ufw logging on
sudo ufw enable
sudo ufw status verbose
sudo ufw status numbered

