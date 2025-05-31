#!/usr/bin/env bash

# Terminal fonts (monospaced, coding oriented)
fonts=(
    fonts-hack
    fonts-proggy
    fonts-firacode
    fonts-inconsolata
    fonts-cascadia-code
    fonts-anonymous-pro
    fonts-jetbrains-mono
    fonts-mononoki
    fonts-powerline
    fonts-terminus
    fonts-ibm-plex
    fonts-noto-cjk
    fonts-noto-hinted
    fonts-noto-color-emoji
    fonts-culmus-fancy
    fonts-sil-ezra
    fonts-sil-charis
    fonts-sil-doulos
    fonts-sil-lateef
    fonts-sil-gentium
    fonts-sil-scheherazade
    fonts-sil-abyssinica
    fonts-sil-andika
    fonts-dejavu
    fonts-lato
    fonts-agave
    fonts-ubuntu
    fonts-roboto
    fonts-open-sans
    fonts-liberation
    fonts-droid-fallback  
    fonts-freefont-ttf
    fonts-liberation2
    fonts-inter
    texlive-fonts-extra
    ttf-bitstream-vera
    ttf-mscorefonts-installer
    typecatcher
    )
sudo dpkg -s "${fonts[@]}" &> /dev/null || sudo apt install -y "${fonts[@]}"
