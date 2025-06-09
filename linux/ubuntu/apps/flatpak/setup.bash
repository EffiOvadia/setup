#!/usr/bin/env bash

# Add FlatPak support
sudo apt update
sudo apt install -y flatpak 
#sudo apt install -y gnome-software-plugin-flatpak gnome-software

# Add the Flathub repository
#flatpak remote-delete --force flathub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# Verify the repository
flatpak remotes
# Update the Flatpak repository
flatpak update -y
# Uninstall unused Flatpak apps
flatpak uninstall --unused


flatpak remote-add --user --if-not-exists elementary https://flatpak.elementary.io/repo.flatpakrepo
flatpak remote-add --user --if-not-exists PureOS     https://store.puri.sm/repo/stable/pureos.flatpakrepo
flatpak remote-add --user --if-not-exists igalia     https://software.igalia.com/flatpak-refs/igalia.flatpakrepo
flatpak remote-add --user --if-not-exists fedora     oci+https://registry.fedoraproject.org
