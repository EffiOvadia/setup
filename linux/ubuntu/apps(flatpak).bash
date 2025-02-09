#!/bin/bash

# Add FlatPak support
sudo apt install -y flatpak gnome-software-plugin-flatpak
# Add the Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Verify the repository
flatpak remotes
flatpak update

## Some usefull FlatPak apps to install
flatpak install flathub -y us.zoom.Zoom
flatpak install flathub -y com.wps.Office
flatpak install flathub -y com.slack.Slack
flatpak install flathub -y com.microsoft.Teams
flatpak install flathub -y com.anydesk.Anydesk
flatpak install flathub -y com.discordapp.Discord
flatpak install flathub -y eu.betterbird.Betterbird
flatpak install flathub -y com.belmoussaoui.Authenticator
flatpak install flathub -y io.github.mimbrero.WhatsAppDesktop
flatpak install flathub -y com.github.micahflee.torbrowser-launcher
# flatpak install flathub -y org.onlyoffice.desktopeditors
# flatpak install flathub -y org.libreoffice.LibreOffice
# flatpak install flathub -y org.chromium.Chromium
# flatpak install flathub -y org.telegram.desktop
# flatpak install flathub -y org.mozilla.firefox
# flatpak install flathub -y com.microsoft.Edge
# flatpak install flathub -y com.brave.Browser
# flatpak install flathub -y com.google.Chrome
# flatpak install flathub -y com.skype.Client 
# flatpak install flathub -y org.signal.Signal

# Uninstall all unused FlatPak apps
#flatpak uninstall -y --unused
# Completly uninstall FlatPak and all installed FlatPak Apps
#sudo apt remove -y --autoremove flatpak && sudo apt purge -y flatpak