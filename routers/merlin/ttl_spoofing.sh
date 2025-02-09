cat > /jffs/scripts/nat-start <<-EOF
#!/bin/sh

sleep 30
modprobe xt_HL
modprobe xt_hl
iptables  -t mangle -A POSTROUTING   -j TTL --ttl-set 66
#iptables  -t mangle -I POSTROUTING 1 -j TTL --ttl-set 66

EOF

chmod a+rx /jffs/scripts/nat-start
