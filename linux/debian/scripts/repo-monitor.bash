#!/usr/bin/env bash

# install inotify-tools if not already installed
sudo dpkg -s inotify-tools >/dev/null 2>&1 || sudo apt install -y inotify-tools

# Create a script to monitor /etc/apt/sources.list.d for new .list files
sudo tee /usr/local/bin/repositories_monitor.sh > /dev/null <<-'EOF'
#!/bin/bash
# Constant: Folder to monitor
WATCH_DIR="/etc/apt/sources.list.d"
# Remove any *.list files created in monitored folder
inotifywait -m -e create --format '%f' "$WATCH_DIR" | 
  while read FILE; do [[ "$FILE" == *.list ]] && rm -f "$WATCH_DIR/$FILE"; done
EOF

# Make the script executable
sudo chmod +x /usr/local/bin/repositories_monitor.sh

# Create a systemd service to run the script
sudo tee /etc/systemd/system/inotify_monitor.service > /dev/null <<-'EOF'
[Unit]
Description=Monitor /etc/apt/sources.list.d for new .list files

[Service]
ExecStart=/usr/local/bin/repositories_monitor.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and enable the service
sudo systemctl daemon-reload
sudo systemctl enable inotify_monitor.service
sudo systemctl start inotify_monitor.service

