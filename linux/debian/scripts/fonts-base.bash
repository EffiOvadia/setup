#!/usr/bin/env bash

# Terminal fonts (monospaced, coding oriented)
fonts=(
    fonts-firacode
    fonts-anonymous-pro
    fonts-inconsolata
    fonts-hack
    fonts-proggy
    fonts-cascadia-code
    fonts-jetbrains-mono
    fonts-mononoki
    fonts-powerline
    fonts-terminus
    fonts-ibm-plex
    )
sudo dpkg -s "${fonts[@]}" &> /dev/null || sudo apt install -y "${fonts[@]}"

# General use fonts
general_fonts=(
    ttf-mscorefonts-installer
    fonts-noto-hinted
    fonts-noto-cjk
    fonts-noto-color-emoji
    fonts-culmus-fancy
    fonts-sil-charis
    fonts-sil-doulos
    fonts-sil-gentium
    fonts-sil-ezra
    fonts-sil-lateef
    fonts-sil-scheherazade
    fonts-sil-abyssinica
    fonts-sil-andika
    fonts-dejavu
    fonts-liberation
    fonts-lato
    fonts-ubuntu
    fonts-droid-fallback
    texlive-fonts-extra
    ttf-bitstream-vera
    fonts-agave
    fonts-roboto
    fonts-open-sans
    fonts-freefont-ttf
    fonts-liberation2
    fonts-inter
    typecatcher
    )
# Install general use fonts
sudo dpkg -s "${fonts[@]}" &> /dev/null || sudo apt install -y "${fonts[@]}"
