#!/bin/sh

ClientID="OVADIA"
OctetRange="50"

### LAN IP/DHCP Configuration ###
nvram set computer_name="Router"
nvram set lan_hostname="Router"
nvram set lan_ipaddr="192.168.$OctetRange.1"
nvram set lan_ipaddr_rt="192.168.$OctetRange.1"
nvram set lan_netmask_rt="255.255.255.0"
nvram set lan_domain="$ClientID.Local"
nvram set dhcp_start="192.168.$OctetRange.20"
nvram set dhcp_end="192.168.$OctetRange.220"
nvram set dhcp_static_x="1"
nvram set ASUS_EULA=1
nvram set ASUS_NEW_EULA=1
nvram set AllLED="1"

### DDNS Configuration ###
nvram set ddns_server_x="WWW.ASUS.COM"
nvram set ddns_hostname_x="$ClientID.asuscomm.com"
nvram set ddns_enable_x="1"
nvram set ddns_updated="1"
nvram set ddns_status="1"

### WAN Configuration ###
nvram set dhcpc_mode="2"
nvram set wandog_enable="1"
nvram set wandog_target="www.qq.com"
nvram set dns_probe="1"
nvram set dns_probe_host="dns.msftncsi.com"
nvram set dns_probe_content="131.107.255.255 112.4.20.71"
nvram set http_enable="2"
nvram set http_autologout="10"

### QoS Configuration ###
nvram set qos_enable="1"
nvram set qos_type="1"
nvram set qos_sched="2"
nvram set qos_overhead="27"
nvram set bwdpi_app_rulelist="9,20<13,24<4<0,5,6,15,17<1,3,14<8<7,10,11,21,23<<customize"
nvram set qos_ibw="0"
nvram set qos_obw="0"

### AIProtection & Security ###
nvram set wrs_protect_enable="1"
nvram set fw_dos_x="1"
nvram set sshd_bfp="1"
nvram set sshd_pass="0"
nvram set sshd_forwarding="1"
nvram set sshd_port="22"
nvram set sshd_passwd_auth="1"
nvram set sshd_enable="1"
nvram set sshd_wanport="22"
nvram set shell_timeout="0"

### SSH Public Keys ###
keys=""
keys="${keys}ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh4Cm/ipoAhQj3+8I6z2AYPzmVxcRJ1v3dqdqyEGAtE"
keys="${keys}>ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNCmaqfNc79iOZbqScO8uLDWBhHRMHUAEbUq3/PR9zj"
nvram set sshd_authkeys="$keys"

### Wireless Configuration ###
nvram set acs_ch13="1"
nvram set smart_connect_x="1"
nvram set wps_enable="0"
nvram set wl0_wps_mode="disabled"
nvram set wl1_wps_mode="disabled"
nvram set wlready="0"
nvram set wps_enable_x="0"
nvram set wps_enable="0"

### LetsEncrypt ###
nvram set le_enable="1"

### NTP Configuration ###
nvram set ntpd_server_redir="1"
nvram set ntp_server0="cn.pool.ntp.org"
nvram set ntp_server1="time.nist.gov"
nvram set ntp_enable="1"
nvram set ntp_ready="1"
nvram set ntp_done="0"
nvram set ntp_mode="auto"
nvram set ntp_success="0"
nvram set ntpd_enable="1"

### DNS & DoT (DNS-over-TLS) ###
nvram set dnsmasq_enable="1"
nvram set dns_norebind="0"
nvram set dnsmasq_no_dns_rebind="1"
nvram set dnssec_enable="1"
nvram set dnssec_check_unsigned_x="1"
nvram set dnspriv_enable="1"
nvram set dnspriv_profile="1"
nvram set dnspriv_rulelist="<1.1.1.1>>cloudflare-dns.com><8.8.8.8>>dns.google><9.9.9.9>>dns.quad9.net><2606:4700:4700::1111>>cloudflare-dns.com><2001:4860:4860::8888>>dns.google><2620:fe::fe>>dns.quad9.net>"

### Miscellaneous Settings ###
nvram set web_redirect="3"
nvram set reboot_schedule_enable="0"
nvram set reboot_schedule="01001000600"
nvram set jffs2_scripts="1"

### OpenVPN Server Configuration ###
nvram set VPNServer_enable="1"
nvram set VPNServer_mode="openvpn"
nvram set vpn_serverx_start="1,2,"
nvram set vpn_server1_state="2"
nvram set vpn_server1_port="1194"
nvram set vpn_server1_proto="udp"
nvram set vpn_server1_local="10.8.0.1"
nvram set vpn_server1_nm="255.255.255.0"
nvram set vpn_server1_ncp_ciphers="AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC"
nvram set vpn_server2_state="2"
nvram set vpn_server2_port="443"
nvram set vpn_server2_proto="udp"
nvram set vpn_server2_local="10.16.0.1"
nvram set vpn_server2_nm="255.255.255.0"
nvram set vpn_server2_ncp_ciphers="AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC"

### Apply and Reboot ###
nvram commit
# reboot


