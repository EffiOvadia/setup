#!/usr/bin/env bash


## Cleaning 
apt update
apt install --install-suggests gnome-software
apps=( gnome-games )
purge  ${apps[@]}
ubuntu-report -f send no
apps=( apt-transport-tor apt-transport-https ca-certificates dirmngr curl wget )
install ${apps[@]}
#-----------------------------------------------------------------------
## Base system, Optimization ✪ 
apps=( f2fs-tools ntfs-3g libfsntfs-utils btrfs-progs dosfstools \
  exfatprogs exfat-fuse zfsutils-linux e2fsck-static xfsprogs hfsutils \
  jfsutils lvm2 udftools gparted gpart gddrescue ethtool clonezilla \
  ddrescueview myrescue safecopy testdisk scalpel foremost ddrutility \ 
  disktype extlinux wxhexeditor chntpw hdparm ipcalc smartmontools \
  zram-tools zram-config )
install ${apps[@]}
#-----------------------------------------------------------------------
apps=( software-properties-common flatpak nala synaptic bleachbit)
install ${apps[@]}
#flatpak remote-add --if-not-exists flathub https://flathub.org/
#-----------------------------------------------------------------------
apps=( putty gnome-terminal tmux vim neovim screen mc lfm htop \
  dnstop iftop iotop zsh powerline cowsay fortune ripgrep tldr \
  bat fzf jq zoxide hyperfine glances btop mutt nmap irssi \
  elinks lynx ncal dateutils ncat rxvt-unicode )
install ${apps[@]}
#exa
#-----------------------------------------------------------------------
apps=( fwupd intel-microcode amd64-microcode cpufrequtils cpu-x)
sudo apt install ${apps[@]}
update-pciids
service fwupd start && fwupdmgr refresh && fwupdmgr get-devices && fwupdmgr get-updates && fwupdmgr update
#-----------------------------------------------------------------------
# The TLP app for older lenovo laptops
#apps=( tlp tlp-rdw )
#install ${apps[@]}
#systemctl enable tlp && systemctl start tlp
#tlp-stat
cpufreq-set -g powersave
#-----------------------------------------------------------------------
## Communications apps
apps=( libreoffice signal-desktop telegram hexchat session-desktop ) 
sudo apt install ${apps[@]}
#-----------------------------------------------------------------------
apps=( brave-browser google-chrome-stable microsoft-edge-stable vivaldi-stable torbrowser-launcher opera-stable )
sudo apt install ${apps[@]}

kleopatra
#-----------------------------------------------------------------------

## Development tools, Shell & Emulators
apps=( build-essential module-assistant linux-headers-$(uname -r) autoconf gcc \
  git git-all gitk git-gui meld wireshark )
sudo apt install ${apps[@]}
#-----------------------------------------------------------------------
#apps=( virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso)
#install ${apps[@]}
#vboxmanage --version
#vboxmanage list extpacks
# VirtualBox Guest Additions Package
# /usr/share/virtualbox/VBoxGuestAdditions.iso
#-----------------------------------------------------------------------
## Desktop Productivity/Office applications
apps=( onlyoffice-desktopeditors libreoffice code keepassxc remmina )
#dropbox)
sudo apt install ${apps[@]}
#-----------------------------------------------------------------------
apps=( darktable inkscape digikam rawtherapee shotwell showfoto krita audacity \
  gimp hugin handbrake shotcut vlc ffmpeg )
sudo apt install ${apps[@]}
  # blender
#-----------------------------------------------------------------------
apps=( openvpn wireguard network-manager-openconnect-gnome openconnect geary \
  filezilla qbittorrent deluge transmission vim-gtk3 )
sudo apt install ${apps[@]}
#-----------------------------------------------------------------------
## Ubuntu media codecs and players
apps=( ubuntu-restricted-extras  ) 
install ${apps[@]}
## Special Hardware drivers and tools
apps=( yubikey-agent yubico-piv-tool yubikey-luks yubikey-manager yubikey-manager-qt \
      yubikey-personalization yubioath-desktop yubioath-desktop libpam-yubico \
      libpam-u2f scdaemon scdaemon )
sudo apt install ${apps[@]}      
apps=( tabby-terminal wezterm solaar helix balena-etcher )
sudo apt install ${apps[@]}
#-----------------------------------------------------------------------
apps=( cloudflare-warp )
install ${apps[@]}
warp-cli registration new && warp-cli connect
#-----------------------------------------------------------------------
ID=7ed392
apps=( nextdns )
install ${apps[@]}
nextdns install && nextdns config set -config $ID && nextdns config
nextdns start && systemctl enable nextdns && systemctl status nextdns
