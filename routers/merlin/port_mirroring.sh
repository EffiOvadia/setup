#!/bin/sh

IP_of_PC_with_Sniffer="192.168.50.100"

# ### to send all traffic to sniffer (mirror all trafic to specific IP)
iptables -I PREROUTING -t mangle -j ROUTE --gw $IP_Of_PC_With_Sniffer --tee
iptables -I POSTROUTING -t mangle -j ROUTE --gw $IP_Of_PC_With_Sniffer --tee

# ### to reset allto defaults
iptables --F -t mangle