
## Internet Browsers, eMail Client  
snap remove thunderbird 
snap remove firefox

sudo \cat > /etc/apt/preferences.d/mozilla <<-EOF
# Set higher priority for Mozilla.org Firefox packages
Package: firefox*
Pin: origin packages.mozilla.org
Pin-Priority: 1001

# Set higher priority for Mozilla.org Firefox packages
Package: thunderbird*
Pin: origin packages.mozilla.org
Pin-Priority: 1001

# Set higher priority for MozillaTeamPPA firefox packages
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

# Set higher priority for MozillaTeamPPA Thunderbird packages
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

# Set lower priority for Canonical firefox (snap) packages
Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1

# Set lower priority for Canonical thunderbird (snap) packages
Package: thunderbird*
Pin: release o=Ubuntu
Pin-Priority: -1
EOF

sudo \cat > /etc/apt/apt.conf.d/51unattended-upgrades-thunderbird <<-EOF
Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";
EOF

apps=( thunderbird firefox )
sudo apt install ${apps[@]}