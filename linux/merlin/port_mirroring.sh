REM ### to send all traffic to sniffer (mirror all trafic to specific IP)
iptables -I PREROUTING -t mangle -j ROUTE --gw (IP-of-PC-with-Sniffer) --tee
iptables -I POSTROUTING -t mangle -j ROUTE --gw (IP-of-PC-with-Sniffer) --tee

REM ### to reset allto defaults
iptables --F -t mangle