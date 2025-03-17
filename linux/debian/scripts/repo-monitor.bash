#!/usr/bin/env bash
sudo dpkg -s inotify-tools >& /dev/null || sudo apt install -y inotify-tools

sudo tee /usr/local/bin/repositories_monitor.sh > /dev/null <<-'EOF'
#!/bin/bash
WATCH_DIR="/etc/apt/sources.list.d"
# Monitor $WATCH_DIR and remove any *.list files created
inotifywait -m -e create --format '%w%f' "$WATCH_DIR" | 
  while read FILE; do [[ "$FILE" == *.list ]] && rm -f "$FILE"; done
EOF
# Make the script executable
sudo chmod +x /usr/local/bin/repositories_monitor.sh




sudo systemctl daemon-reload
sudo systemctl enable inotify_monitor.service
sudo systemctl start inotify_monitor.service

