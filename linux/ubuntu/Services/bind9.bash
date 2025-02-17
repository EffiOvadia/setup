#!/usr/bin/env bash

apt install -y bind9 bind9utils bind9-doc dnstop dnscrypt-proxy dnscrypt-proxy-plugins unbound ldnsutils

cat > /etc/bind/named.conf.options <<-EOF
//      FORWARDING & CACHING NAME SERVER
//      Created by: Effi Ovadia

options {
        directory "/var/cache/bind";
        query-source address * port 53;                     # prevent firewall problem
        version "not currently available";                  # hiding version statement
        listen-on-v6                  { none           ; }; # disable IPv6
        listen-on                     { any            ; }; # bind service to all interfaces
//      listen-on                     { 127.0.0.1      ; }; # bind service to loopback (port 53)
//      listen-on                     { 192.168.2.5    ; }; # bind service to local IP addess
//      listen-on port 5353           { any            ; }; # chnage listening port to 5353
//      also-notify port 5353         { any            ; }; # notify slave name servers 
//      forwarders                    { 127.0.2.1      ; }; # fwd to local DNSCrypt deamon
        forwarders   { 208.67.222.222 ; 208.67.220.220 ; }; # fwd to OpenDNS 
//      forwarders   { 208.67.222.123 ; 208.67.220.123 ; }; # fwd to OpenDNS FamilyShield
//      forwarders   { 198.153.192.50 ; 198.153.194.50 ; }; # fwd to Norton ConnectSafe B
//      forwarders   { 198.153.192.60 ; 198.153.194.60 ; }; # fwd to Norton ConnectSafe C
//      forwarders   { 77.88.8.7      ; 77.88.8.3      ; }; # fwd to Yandex Family
//      forwarders   { 81.218.119.11  ; 209.88.198.133 ; }; # fwd to GreenTeam
//      allow-query  { 172.16.0.0/12  ; 192.168.0.0/16 ; }; # serve local networks only
        allow-notify                  { none           ; }; #
        allow-transfer                { none           ; }; # disables zone transfer
        allow-update-forwarding       { none           ; }; # 
        allow-recursion               { any            ; }; #
        allow-recursion-on            { any            ; }; #
        forward only;                                       # do not iterate
        recursion yes;                                      # do caching (explicitly)
        max-ncache-ttl 3;                                   # not cache failed queries
        auth-nxdomain no;                                   # conform to RFC1035
        };
EOF

systemctl restart bind9
systemctl status  bind9 