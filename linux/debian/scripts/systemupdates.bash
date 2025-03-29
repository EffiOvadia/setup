#!/usr/bin/env bash

# Install unattended-upgrades
sudo dpkg -s unattended-upgrades >/dev/null 2>&1 || sudo apt install -y unattended-upgrades
# Configure unattended-upgrades
sudo \cat > /etc/apt/apt.conf.d/20auto-upgrades <<-'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF
sudo dpkg-reconfigure -plow unattended-upgrades
