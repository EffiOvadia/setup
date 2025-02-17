#!/usr/bin/env bash

# Add FlatPak support
sudo apt install -y flatpak gnome-software-plugin-flatpak
# Add the Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Verify the repository
flatpak remotes
flatpak update

# ===============================================

flatpak remote-delete --force flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
