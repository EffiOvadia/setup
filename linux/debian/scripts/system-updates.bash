#!/usr/bin/env bash

# Install unattended-upgrades
sudo apt --assume-yes install unattended-upgrades
# Configure unattended-upgrades
sudo \cat > /etc/apt/apt.conf.d/20auto-upgrades <<-'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF
sudo dpkg-reconfigure -plow unattended-upgrades