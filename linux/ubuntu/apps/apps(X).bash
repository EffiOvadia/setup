#!/usr/bin/env bash

# Install yubico apps and tools
apps=( yubikey-agent yubico-piv-tool yubikey-luks yubikey-manager yubikey-manager-qt \
      yubikey-personalization yubioath-desktop yubioath-desktop libpam-yubico \
      libpam-u2f scdaemon scdaemon )
sudo apt install -y ${apps[@]}
# Install VPN and network tools
apps=( openvpn wireguard network-manager-openconnect-gnome openconnect )
sudo apt install -y ${apps[@]}
# Install Office and document editors
apps=( onlyoffice-desktopeditors libreoffice )
sudo apt install -y ${apps[@]}
# Install editors and IDEs
apps=( code codium vim-gtk3 helix )
sudo apt install -y ${apps[@]}
# Install browsers
apps=( brave-browser google-chrome-stable microsoft-edge-stable vivaldi-stable torbrowser-launcher opera-stable )
sudo apt install -y ${apps[@]}
# Install communication apps
apps=( signal-desktop telegram hexchat session-desktop )
sudo apt install -y ${apps[@]}
# Install gereral tools
apps=( remmina keepassxc solaar balena-etcher )
sudo apt install -y ${apps[@]}
# Install terminal emulators and shells
apps=( wezterm warp tabby-terminal )
sudo apt install -y ${apps[@]}
#-----------------------------------------------------------------------
apps=( virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso)
sudo apt install -y ${apps[@]}
sudo usermod -aG vboxusers $USER
#vboxmanage --version
#vboxmanage list extpacks
# VirtualBox Guest Additions Package
# /usr/share/virtualbox/VBoxGuestAdditions.iso
#-----------------------------------------------------------------------
ID=7ed392
apps=( nextdns )
sudo apt install -y ${apps[@]}
nextdns install && nextdns config set -config $ID && nextdns config
nextdns start && systemctl enable nextdns && systemctl status nextdns
#dropbox