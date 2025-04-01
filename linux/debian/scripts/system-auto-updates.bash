#!/usr/bin/env bash

# Install unattended-upgrades
sudo dpkg -s unattended-upgrades >/dev/null 2>&1 || sudo apt install -y unattended-upgrades
sudo dpkg -s powermgmt-base      >/dev/null 2>&1 || sudo apt install -y powermgmt-base
# Configure unattended-upgrades
sudo \cat > /etc/apt/apt.conf.d/20auto-upgrades <<-'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

sed -i '/Unattended-Upgrade::Allowed-Origins {/,/};/c\
Unattended-Upgrade::Allowed-Origins {\
    "${distro_id}:${distro_codename}";\
    "${distro_id}ESMApps:${distro_codename}-apps-security";\
    "${distro_id}ESM:${distro_codename}-infra-security";\
    "${distro_id}:${distro_codename}-updates";\
    "${distro_id}:${distro_codename}-security";\
    "${distro_id}:${distro_codename}-proposed";\
    "${distro_id}:${distro_codename}-backports";\
};' /etc/apt/apt.conf.d/50unattended-upgrades

grep -q -e '^Unattended-Upgrade::Automatic-Reboot "true";' /etc/apt/apt.conf.d/50unattended-upgrades || 
  echo 'Unattended-Upgrade::Automatic-Reboot "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
grep -q -e '^Unattended-Upgrade::Automatic-Reboot-Time "04:00";' /etc/apt/apt.conf.d/50unattended-upgrades || 
  echo 'Unattended-Upgrade::Automatic-Reboot-Time "04:00";' >> /etc/apt/apt.conf.d/50unattended-upgrades

sudo \cat > /etc/apt/preferences.d/unattended-upgrades <<-'EOF'
Package: *
Pin: origin "releases.warp.dev"
Pin-Priority: 500

Package: *
Pin: origin "ppa.launchpadcontent.net"
Pin-Priority: 500
EOF

sudo dpkg-reconfigure -plow unattended-upgrades
sudo systemctl enable unattended-upgrades.service
sudo systemctl restart unattended-upgrades.service

sudo unattended-upgrades --dry-run --debug
