#!/usr/bin/env bash

### Configuring OpenSSH server
sudo apt install -y openssh-server rsync fail2ban
### -----------------------------------------------------------------
sudo touch /etc/ssh/authorized_keys
sudo chmod 600 /etc/ssh/authorized_keys
sudo chown root:root /etc/ssh/authorized_keys
sudo \cat > /etc/ssh/authorized_keys <<-'EOF'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh4Cm/ipoAhQj3+8I6z2AYPzmVxcRJ1v3dqdqyEGAtE 
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNCmaqfNc79iOZbqScO8uLDWBhHRMHUAEbUq3/PR9zj 
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH1AN8iuL/4NhkKCXyJnPsiQyU2KkvwoMcUt3nZQFRBf 
EOF
### -----------------------------------------------------------------
sudo sed -i.bak \
     -e 's/[# ]*UseDNS.*/UseDNS no/g' \
     -e 's/[# ]*GatewayPorts.*/GatewayPorts yes/g' \
     -e 's/[# ]*PubkeyAuthentication.*/PubkeyAuthentication yes/g' \
     -e 's/[# ]*PermitRootLogin.*/PermitRootLogin prohibit-password/g' \
     -e 's/[# ]*AuthorizedKeysFile.*/AuthorizedKeysFile \/etc\/ssh\/authorized_keys .ssh\/authorized_keys /g' \
     -e 's/[# ]*Banner \/etc\/issue.net/Banner \/etc\/issue.net/g' \
          /etc/ssh/sshd_config
### -----------------------------------------------------------------
### Configuring Fail2Ban
sudo \cp --force /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo sed -i.bak \
     -e 's/^ignoreip =.*/ignoreip = 127.0.0.1\/8 192.168.0.1\/16/g' \
     -e 's/^action = %(action_)s/action = %(action_mw)s/g' \
     -e 's/^mta = sendmail/mta = mail/g' \
          /etc/fail2ban/jail.local
### -----------------------------------------------------------------
sudo bash -c 'echo Welcome to $HOSTNAME > /etc/motd'
### -----------------------------------------------------------------
sudo systemctl restart ssh.service
sudo systemctl enable --now ssh
### -----------------------------------------------------------------
#sed -i 's/[# ]*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
#systemctl restart ssh.service
