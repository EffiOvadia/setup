#!/usr/bin/env bash

apt install -y unbound

### ------------------------------------------------------
cat > /etc/unbound/unbound.conf.d/forward-zone.conf <<-EOF
forward-zone:
  name: "."
#   forward-addr: 2606:4700:4700::1111  #one.one.one.one
#   forward-addr: 2606:4700:4700::1001  #one.one.one.one
    forward-addr: 1.1.1.1               #one.one.one.one
    forward-addr: 1.0.0.1               #one.one.one.one
#   forward-addr: 2001:4860:4860::8888  #Google
#   forward-addr: 2001:4860:4860::8844  #Google
    forward-addr: 8.8.8.8               #Google
    forward-addr: 8.8.4.4               #Google
    forward-addr: 9.9.9.9               #Quad9
EOF

### ------------------------------------------------------
cat > /etc/unbound/unbound.conf.d/server.conf <<-EOF
server:
  access-control:         0.0.0.0/0 allow
  interface:              0.0.0.0
  cache-max-ttl:          14400
  cache-min-ttl:          300
  minimal-responses:      yes
  prefetch:               yes
  qname-minimisation:     yes
  rrset-roundrobin:       yes  
  do-not-query-localhost: no
EOF

### ------------------------------------------------------
systemctl stop    systemd-resolved
systemctl disable systemd-resolved
grep -q -e 'dns=unbound' /etc/NetworkManager/NetworkManager.conf || sed -i -e '/\[main]/{:a;n;/^$/!ba;i\dns=unbound' -e '}' /etc/NetworkManager/NetworkManager.conf
rm /etc/resolv.conf

### ------------------------------------------------------
systemctl enable  unbound-resolvconf
systemctl enable  unbound.service
systemctl restart network-manager


### status -----------------------------------------------
systemctl status  systemd-resolved
systemctl status  unbound.service
systemctl status  network-manager
