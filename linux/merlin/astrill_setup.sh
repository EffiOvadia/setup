### Astrill
nvram set astrill_vpnmode="6"
nvram set astrill_abort="0"
### Protocol ( 2 = UDP / 3 = TCP )
nvram set astrill_protocol="2"
### Port ( Auto )
nvram set astrill_port="1-65535"
### Encryption Type
nvram set astrill_cipher="default"
### MTU 
nvram set astrill_wanmtu="1446"
### Enable Accelerato
nvram set astrill_accel="1"
### Block Internet if VPN drops
nvram set astrill_blockinternet="0"
### Auto reconnect to next favorite server
nvram set astrill_autocycle="1"
### Start Automatically
nvram set astrill_autostart="1"
### VPN Mode ( 1 = Smart Mode for China )
nvram set astrill_routingmode="3"
### Block Ads if Astrill DNS is used
nvram set astrill_adsblock="1"
### Exclude these IPs or domains (optional)
#nvram set astrill_iplistraw="TAOBAO.com"
### Device Filter Tunnel through VPN ( 0 = all / 2 = Exclude selected )
nvram set astrill_devmode="0"
nvram set astrill_ifmode="0"
### Exceptions ( Excluded Ports/IP on local LAN from Astrill )
#nvram set astrill_exflt="ANY,11011,ANY,ANY,ANY,ISP;ANY,ANY,ANY,11011,ANY,ISP"
#nvram set astrill_exflt="ANY,ANY,ANY,25,ANY,ISP;ANY,ANY,ANY,465,ANY,ISP;ANY,ANY,ANY,587,ANY,ISP;ANY,ANY,ANY,110,ANY,ISP;ANY,ANY,ANY,143,ANY,ISP;ANY,ANY,ANY,993,ANY,ISP;ANY,ANY,ANY,995,ANY,ISP"
### DNS Servers ( 0 = Astrill DNS | 255 = Router's DNS | 254 = User's DNS)
nvram set astrill_dnsserver="255"
nvram set astrill_userdns="1.1.1.1 9.9.9.9"
### Use VPN DNS also for excluded devices
nvram set astrill_nosplitdns="1"
### Use VPN DNS also for excluded web sites
nvram set astrill_vpndnsallsites="0"
### Commit
nvram commit
### Astrill favorite server list (non VIP)
nvram set astrill_favlist="286:536871198:1-65535:0:6:286,353:536871265:1-65535:0:6:353,622:536871534:1-65535:0:6:622,940:536871852:1-65535:0:6:940,1142:536872054:1-65535:0:6:1142"
nvram set astrill_serverid="622"
nvram set astrill_sid="622"
nvram commit
### Astrill favorite server list (VIP)
nvram set astrill_favlist="533:536871445:1-65535:0:6:533,636:536871548:1-65535:0:6:636,941:536871853:1-65535:0:6:941,1091:536872003:1-65535:0:6:1091,268436310:805307222:1-65535:0:6:268436310,268436545:805307457:1-65535:0:6:268436545"
nvram set astrill_serverid="533"
nvram set astrill_sid="533"
nvram commit
########################################
/dev/astrill/astrillvpn start && sleep 5 && /dev/astrill/astrill_getstatus
