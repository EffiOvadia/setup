#!/usr/bin/env bash

### Configuring OpenSSH server
apt install -y openssh-server rsync fail2ban
### -----------------------------------------------------------------
sed -i \
     -e 's/[# ]*UseDNS.*/UseDNS no/g' \
     -e 's/[# ]*GatewayPorts.*/GatewayPorts yes/g' \
     -e 's/[# ]*PubkeyAuthentication.*/PubkeyAuthentication yes/g' \
     -e 's/[# ]*PermitRootLogin.*/PermitRootLogin prohibit-password/g' \
     -e 's/[# ]*Banner \/etc\/issue.net/Banner \/etc\/issue.net/g' \
          /etc/ssh/sshd_config
### -----------------------------------------------------------------
### Configuring Fail2Ban
\cp --force /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sed -i \
     -e 's/^ignoreip =.*/ignoreip = 127.0.0.1\/8 192.168.0.1\/16/g' \
     -e 's/^action = %(action_)s/action = %(action_mw)s/g' \
     -e 's/^mta = sendmail/mta = mail/g' \
          /etc/fail2ban/jail.local
### -----------------------------------------------------------------
echo Welcome to $HOSTNAME > /etc/motd
### -----------------------------------------------------------------
systemctl restart ssh.service
systemctl enable --now ssh
### -----------------------------------------------------------------


sed -i 's/[# ]*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart ssh.service
