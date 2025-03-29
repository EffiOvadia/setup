#!/usr/bin/env bash
## Telegram Alerts
# Install curl if not installed
dpkg -s curl &> /dev/null || apt install --assume-yes curl
# Create a script to send Telegram notifications 
sudo \cat > /usr/local/bin/send-telegram.sh <<-'EOF'
#!/bin/bash
BOT_TOKEN="8068305905:AAEu4CtjanfAGUaF7-hJ247WGhSZYCpGplo"
CHAT_ID="408986462"
MESSAGE="$1"
# Check if the message is empty
[ -z "$MESSAGE" ] && { echo "Usage: $0 \"message text\""; exit 1; }
# Send the message to the Telegram bot
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d chat_id="$CHAT_ID" \
     -d text="$MESSAGE" > /dev/null 2>&1
EOF
# Make the script executable
sudo chmod +x /usr/local/bin/send-telegram.sh

/usr/local/bin/send-telegram.sh "$(date) "$'\n'"🔵 Test from $USER@$HOSTNAME"
