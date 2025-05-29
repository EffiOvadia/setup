#!/usr/bin/env bash

## Cleaning 
apt install --install-suggests gnome-software
apps=( gnome-games )
purge  ${apps[@]}
ubuntu-report -f send no
apps=( apt-transport-tor apt-transport-https ca-certificates dirmngr curl wget )
sudo apt install -y ${apps[@]}
#-----------------------------------------------------------------------
## Base system, Optimization ✪ 
apps=( f2fs-tools ntfs-3g libfsntfs-utils btrfs-progs dosfstools \
  exfatprogs exfat-fuse zfsutils-linux e2fsck-static xfsprogs hfsutils \
  jfsutils lvm2 udftools gparted gpart gddrescue ethtool clonezilla \
  ddrescueview myrescue safecopy testdisk scalpel foremost ddrutility \ 
  disktype extlinux wxhexeditor chntpw hdparm ipcalc smartmontools \
  zram-tools zram-config )
sudo apt install -y ${apps[@]}
#-----------------------------------------------------------------------
apps=( software-properties-common flatpak nala synaptic bleachbit)
sudo apt install -y ${apps[@]}
#flatpak remote-add --if-not-exists flathub https://flathub.org/
#-----------------------------------------------------------------------
apps=( putty gnome-terminal tmux vim neovim screen mc lfm htop \
  dnstop iftop iotop zsh powerline cowsay fortune ripgrep tldr \
  bat fzf jq zoxide hyperfine glances btop mutt nmap irssi \
  elinks lynx ncal dateutils ncat rxvt-unicode )
sudo apt install -y ${apps[@]}
#exa
#-----------------------------------------------------------------------
apps=( darktable digikam rawtherapee shotwell showfoto krita audacity \
  gimp hugin handbrake shotcut vlc ffmpeg )
sudo apt install -y ${apps[@]}

inkscape
#-----------------------------------------------------------------------
## Development tools, Shell & Emulators
apps=( build-essential module-assistant linux-headers-$(uname -r) autoconf gcc \
  git git-all gitk git-gui meld wireshark )
sudo apt install -y ${apps[@]}
#-----------------------------------------------------------------------
apps=( fwupd intel-microcode amd64-microcode cpufrequtils cpu-x)
sudo apt install -y ${apps[@]}
update-pciids
service fwupd start && fwupdmgr refresh && fwupdmgr get-devices && fwupdmgr get-updates && fwupdmgr update
#-----------------------------------------------------------------------
# The TLP app for older lenovo laptops
#apps=( tlp tlp-rdw )
#sudo apt install -y ${apps[@]}
#systemctl enable tlp && systemctl start tlp
#tlp-stat
cpufreq-set -g powersave

#kleopatra
#-----------------------------------------------------------------------
apps=( darktable inkscape digikam rawtherapee shotwell showfoto krita audacity \
  gimp hugin handbrake shotcut vlc ffmpeg )
sudo apt install -y ${apps[@]}

#-----------------------------------------------------------------------
apps=( geary filezilla qbittorrent deluge transmission )
sudo apt install -y ${apps[@]}
#-----------------------------------------------------------------------
## Ubuntu media codecs and players
apps=( ubuntu-restricted-extras  ) 
sudo apt install -y ${apps[@]}
#-----------------------------------------------------------------------
apps=( cloudflare-warp )
sudo apt install -y ${apps[@]}
warp-cli registration new && warp-cli connect
#-----------------------------------------------------------------------
ubuntu-drivers list
ubuntu-drivers install