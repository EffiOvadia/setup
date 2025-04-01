#!/usr/bin/env bash

## SSH Alerts via Telegram

## Create a script to notify about successful SSH logins
sudo \cat > /etc/ssh/ssh-login-notify.sh <<-'EOF'
#!/bin/bash
# Send message via telegram about ssh login
TELEGRAM_SCRIPT="/usr/local/bin/send-telegram.sh"
MESSAGE="$(date +"%Y-%m-%d %I:%M:%S %p") $HOSTNAME:"$'\n'"🟢 $PAM_USER@$PAM_RHOST"
[ "$PAM_TYPE" = "open_session" ] && $TELEGRAM_SCRIPT "$MESSAGE"
EOF
# Make the script executable  
sudo chmod +x /etc/ssh/ssh-login-notify.sh
# Add the script to the PAM configuration
grep -q -e 'session optional pam_exec.so /etc/ssh/ssh-login-notify.sh' /etc/pam.d/sshd || 
  echo 'session optional pam_exec.so /etc/ssh/ssh-login-notify.sh' >> /etc/pam.d/sshd

## Create a script to notify about failed SSH logins
sudo \cat > /etc/fail2ban/action.d/telegram-notify.conf <<-'EOF'
[Definition]
actionstart = echo "Fail2ban started monitoring SSH" | logger
actionstop = echo "Fail2ban stopped monitoring SSH" | logger
actioncheck =
actionban = /usr/local/bin/send-telegram.sh "$(date +'%Y-%m-%d %I:%M:%S %p')$HOSTNAME:"$'\n'"🔴 <user>@<ip>"
actionunban =
EOF
# Restart the Fail2Ban service to apply changes
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd
# Reload the SSH service to apply changes
sudo systemctl restart ssh.service
# Test the telegram alert sending script