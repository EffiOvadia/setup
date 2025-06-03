#!/usr/bin/env bash
# Install Twingate Connector
sudo dpkg -s twingate-connector &> /dev/null || sudo apt install -y twingate-connector
#  Create the config directory
sudo install -d -m 0700 /etc/twingate
# Create the configuration file with placeholders
sudo tee /etc/twingate/connector.conf >/dev/null <<'EOF'
TWINGATE_NETWORK=
TWINGATE_ACCESS_TOKEN=
TWINGATE_REFRESH_TOKEN=
EOF
# Lock permissions
sudo chmod 600 /etc/twingate/connector.conf
# Enable and start the service
sudo systemctl enable --now twingate-connector
# Verify the service status
systemctl status twingate-connector
journalctl -u twingate-connector -e
