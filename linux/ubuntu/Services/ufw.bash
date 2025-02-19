#!/usr/bin/env bash

apt install -y ufw
rm /etc/ufw/applications.d/*
### ------------------- DNS ----------------------------------------------------------------------
[ -f /etc/ufw/applications.d/dns ] && rm /etc/ufw/applications.d/dns
\cat > /etc/ufw/applications.d/dns <<-EOF
[DNS]
title=Domain Name Resolution Service
description=Port 53/udp
ports=53/udp
EOF
### ------------------- OpenSSH ------------------------------------------------------------------
\cat > /etc/ufw/applications.d/openssh <<-EOF
[OpenSSH]
title=Secure shell server, an rshd replacement
description=OpenSSH is a free implementation of the Secure Shell protocol.
ports=22/tcp
EOF
### ------------------- OpenVPN -----------------------------------------------------------------
\cat > /etc/ufw/applications.d/openvpn <<-EOF
[OpenVPN]
title=OpenVPN server
description=OpenVPN
ports=1194/udp
EOF
### ------------------- Samba --------------------------------------------------------------------
\cat > /etc/ufw/applications.d/samba <<-EOF
[Samba]
title=LanManager-like file and printer server for Unix
description=The Samba software suite is a collection of programs that implements the SMB/CIFS protocol for unix systems, allowing you to serve files and printers to Windows, NT, OS/2 and DOS clients. This protocol is sometimes also referred to as the LanManager or NetBIOS protocol.
ports=137,138/udp|139,445/tcp
EOF
### ---------------------------------------------------------------------------------------------
\cat > /etc/ufw/applications.d/wireguard <<-EOF
[WireGuard]
title=WireGuard VPN Server
description=WireGuard Server 
ports=51820/udp
EOF
### ---------------------------------------------------------------------------------------------
\cat > /etc/ufw/applications.d/unifi <<-EOF
[UniFi]
title=Ubiquiti Networks - UniFi Controller Server
description=UniFi Controller for AccessPoints, Switches and Other UniFi products
ports=3478,10001,1900,5656:5699/udp|8080,8443,8880,8843,6789,27117/tcp
EOF
## ---------------------------------------------------------------------------------------------
\cat > /etc/ufw/applications.d/nfs <<-EOF
[NFSv4]
title=Network File System version 4
description=NFSv4 allows a system to share directories and files with others over a network using TCP port 2049.
ports=2049/tcp
EOF
### ---------------------------------------------------------------------------------------------

ufw reset
ufw disable
ufw default allow outgoing
ufw default deny  incoming
ufw app update all 
#ufw allow from any to 0.0.0.0/0 app  DNS       comment "DNS"
ufw allow from any to 0.0.0.0/0 app  NFSv4      comment "NFSv4"
#ufw allow from any to 0.0.0.0/0 app  Samba     comment "Samba"
ufw allow from any to 0.0.0.0/0 app  OpenSSH   comment "OpenSSH"
#ufw allow from any to 0.0.0.0/0 app  OpenVPN   comment "OpenVPN"
#ufw allow from any to 0.0.0.0/0 app  WireGuard comment "WireGuard"
#ufw allow from any to 0.0.0.0/0 app  UniFi     comment "UniFi"
ufw logging on
ufw enable
ufw status verbose
ufw status numbered
### ---------------------------------------------------------------------------------------------
systemctl restart ufw.service
### ---------------------------------------------------------------------------------------------

