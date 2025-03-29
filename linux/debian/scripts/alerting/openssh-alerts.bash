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
actionban = /usr/local/bin/send-telegram.sh "$(date +'%Y-%m-%d %I:%M:%S %p') <fq-host>:$'\n' 🔴 <user> @ <ip>"
actionunban =
EOF
# Update the Fail2Ban configuration to use the new action
awk 'BEGIN {
  attr["enabled"]   = "enabled = true"; 
  attr["filter"]    = "filter = sshd"; 
  attr["maxretry"]  = "maxretry = 3"; 
  attr["findtime"]  = "findtime = 600"; 
  attr["bantime"]   = "bantime = 600"; 
  attr["action"]    = "action = telegram-notify"; 
  for(a in attr) seen[a]=0; 
  in_section=0
        } 
/^\[sshd\]/ { in_section=1; for(a in seen) seen[a]=0; print; next} 
in_section && /^[[:space:]]*$/ { for(a in attr) if(!seen[a]) print attr[a]; in_section=0; print; next } 
in_section && /^\[/ { for(a in attr) if(!seen[a]) print attr[a]; in_section=0; print; next } 
in_section && /^[[:space:]]*(enabled|filter|maxretry|findtime|bantime|action)[[:space:]]*=/ \
  { if(match($0,/^[[:space:]]*([^[:space:]]+)[[:space:]]*=[[:space:]]*(.*)$/,m)) { key = m[1]; if($0 ~ ("^" attr[key] "$")) { print; } else { print attr[key]; } seen[key]=1; next }} 
{ print } END { if(in_section){ for(a in attr) if(!seen[a]) print attr[a] }}' \
  /etc/fail2ban/jail.local | sudo tee /etc/fail2ban/jail.local > /dev/null
# Restart the Fail2Ban service to apply changes
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd
# Reload the SSH service to apply changes
sudo systemctl restart ssh.service
# Test the telegram alert sending script