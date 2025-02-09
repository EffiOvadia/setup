pacman -Syu
pacman -S --needed xorg xorg-server
pacman -S --needed gnome gnome-extra
systemctl start gdm.service
systemctl enable gdm.service
#systemctl stop gdm.service
#systemctl disable gdm.service

## Bluetooth
pacman -S bluez bluez-utils 
systemctl start bluetooth.service && systemctl enable bluetooth.service
## Audio 
pacman -S pulseaudio pulseaudio-alsa

## Extra Filesystem format support:& Data recovery applications
pacman -Syu --needed gparted testdisk foremost f2fs-tools ntfs-3g btrfs-progs dosfstools exfat-utils xfsprogs jfsutils
## Linux Shell
pacman -Syu --needed zsh ksh fish tcsh
## General Productivity Application
pacman -Syu --needed tmux vim emacs screen mc mutt htop 
## Internet 
pacman -Syu --needed chrome-gnome-shell filezilla firefox thunderbird qbittorrent deluge telegram-desktop thunderbird openvpn chromium
## Office & Multimedia
pacman -Syu --needed libreoffice-fresh abiword gimp hugin darktable inkscape digikam rawtherapee scribus shotwell krita audacity blender vlc calibre texmaker lyx texstudio gummi

