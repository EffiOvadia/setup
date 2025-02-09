apt install -y isc-dhcp-server

cat >/etc/dhcp/dhcpd.conf <<-EOF:q
authoritative;
ddns-update-style none;
default-lease-time 3600;
option subnet-mask 255.255.255.0;
option domain-name-servers 8.8.8.8, 8.8.4.4;
max-lease-time 86400;

subnet  192.168.2.0  netmask 255.255.255.0 
        {
        range                       192.168.2.20 192.168.2.220;
        option routers              192.168.2.1;
        option subnet-mask          255.255.255.0;
        option broadcast-address    192.168.2.255;
        option ntp-servers          192.168.50.1;
        option domain-name-servers  192.168.2.1;
        option domain-name          "Local";
        }

subnet  192.168.50.0 netmask 255.255.255.0 
        {
        range                       192.168.50.20 192.168.50.220;
        option routers              192.168.50.1;
        option subnet-mask          255.255.255.0;
        option broadcast-address    192.168.50.255;
        option ntp-servers          192.168.50.1;
        option domain-name-servers  192.168.50.1;
        option domain-name          "Local";
        }
EOF

#systemctl stop    isc-dhcp-server
systemctl restart isc-dhcp-server
systemctl status  isc-dhcp-server