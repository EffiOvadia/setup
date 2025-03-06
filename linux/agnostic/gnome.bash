#!/bin/bash

#gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'

# Make Dock Transparent
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.5

# Icon Size in Dock
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 30

# Workspace Mode (Dynamic or Fixed Number)
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5

# Switch Workspaces with Edge Pressure:
gsettings set org.gnome.shell.overrides edge-tiling true

# Enable Window Tiling and Snapping:
gsettings set org.gnome.mutter edge-tiling true

# Show or Hide Desktop Icons:
gsettings set org.gnome.desktop.background show-desktop-icons false

# Theme:
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.shell.extensions.user-theme name 'Adwaita'

# Text Scaling Factor:
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0

# Laptop Lid Close Behavior (nothing, suspend, hibernate, shutdown):
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'suspend'

# Disable Automatic Suspend on AC Power:
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

# Set Font:
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ font 'Cascadia Code 11'

# Set Terminal Size to 130 Columns and 30 Rows:
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ default-size-columns 130
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ default-size-rows 30

# Disable Theme Colors and Apply Custom Colors:
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ background-color 'rgb(0,0,0)'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ foreground-color 'rgb(255,255,255)'

# Enable Transparency and Set Background Transparency to 0.9 (10% Transparency):
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-transparent-background true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ background-transparency-percent 15

gsettings set org.gnome.desktop.interface font-name "Adwaita Sans 11"
gsettings set org.gnome.desktop.interface monospace-font-name "Adwaita Mono 11"

#gsettings reset org.gnome.desktop.interface font-name
#gsettings reset org.gnome.desktop.interface monospace-font-name

