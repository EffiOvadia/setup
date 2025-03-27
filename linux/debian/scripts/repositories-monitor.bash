#!/usr/bin/env bash

# install inotify-tools if not already installed
sudo dpkg -s inotify-tools >/dev/null 2>&1 || sudo apt install -y inotify-tools

# Create a backup folder
mkdir -p /backup
# Create a script to monitor /etc/apt/sources.list.d for new .list files
sudo tee /usr/local/bin/repositories_monitoring.sh > /dev/null <<-'EOF'
#!/bin/bash
# Constant: Folder to monitor
WATCH_DIR="/etc/apt/sources.list.d"
# Remove any *.list files created in monitored folder
inotifywait -m -e create --format '%f' "$WATCH_DIR" | 
  while read FILE; do [[ "$FILE" == *.list ]] && mv -f "$WATCH_DIR/$FILE" "/backup/${FILE}_$(date +%Y-%m-%d)" ; done
EOF
# Make the script executable
sudo chmod +x /usr/local/bin/repositories_monitoring.sh

# Create a systemd service to run the script
sudo tee /etc/systemd/system/inotify_monitor.service > /dev/null <<-'EOF'
[Unit]
Description=Monitor /etc/apt/sources.list.d for new .list files

[Service]
ExecStart=/usr/local/bin/repositories_monitoring.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and enable the service
sudo systemctl daemon-reload
# Enable and start the service
sudo systemctl enable  inotify_monitor.service
sudo systemctl restart inotify_monitor.service

