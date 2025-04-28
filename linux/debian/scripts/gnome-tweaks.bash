#!/bin/bash

sudo dpkg -s curl &> /dev/null || sudo apt install -y curl

## Gnome System extensions
for ext in $(gnome-extensions list); do gnome-extensions enable "$ext"; done
for dir in /usr/share/gnome-shell/extensions/*/; do uuid=$(basename "$dir"); gnome-extensions enable "$uuid"; done

# list of system extensions to Install and enable (provided by Ubuntu repo)
EXTENSIONS=(
  "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
  "drive-menu@gnome-shell-extensions.gcampax.github.com"
  "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
  "light-style@gnome-shell-extensions.gcampax.github.com"
  "native-window-placement@gnome-shell-extensions.gcampax.github.com"
  "places-menu@gnome-shell-extensions.gcampax.github.com"
  "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
  "system-monitor@gnome-shell-extensions.gcampax.github.com"
  "tiling-assistant@ubuntu.com"
  "ubuntu-appindicators@ubuntu.com"
  "ubuntu-dock@ubuntu.com"
  "user-theme@gnome-shell-extensions.gcampax.github.com"
  "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
  )
# Install and enable system extensions 
for EXTENTION in "${EXTENSIONS[@]}"; do gnome-extensions enable "$EXTENTION" ; done
# list of system extensions to disable
EXTENSIONS=( 
  "apps-menu@gnome-shell-extensions.gcampax.github.com"
  "window-list@gnome-shell-extensions.gcampax.github.com"
  "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
  )
# Disable system extensions that are not needed
for EXTENTION in "${EXTENSIONS[@]}"; do gnome-extensions disable "$EXTENTION" ; done
## Gnome User extensions
# list of user extensions to Install and enable 
EXTENSIONS=(
  "blur-my-shell@aunetx"
  "burn-my-windows@schneegans.github.com"
  "compiz-windows-effect@hermes83.github.com"
  "desktop-cube@schneegans.github.com"
  "dim-background-windows@stephane-13.github.com"
  )
# Function to install and enable a GNOME user extension
install_extension() 
  {
    local uuid="$1"
    if gnome-extensions info "$uuid" &> /dev/null; then return; fi
    # Get GNOME Shell version
    shell_version=$(gnome-shell --version | awk '{print $3}')
    # Fetch extension info from GNOME Extensions website
    info_json=$(curl -sS "https://extensions.gnome.org/extension-info/?uuid=$uuid&shell_version=$shell_version")
    # Extract download URL
    download_url=$(echo "$info_json" | jq ".download_url" --raw-output)
    [ "$download_url" == "null" ] && { echo "Error: Extension $uuid is not compatible with GNOME Shell version $shell_version."; return; }
    # Download and install the extension
    curl -sL "https://extensions.gnome.org$download_url" -o "$uuid.zip"
    gnome-extensions install "$uuid.zip"   
    # Enable the extension
    gnome-extensions enable "$uuid"
    rm "$uuid.zip"
  }

# Install all extensions from the list
for EXTENSION in "${EXTENSIONS[@]}"; do install_extension "$EXTENSION"; done

## Tweaks and settings for the installed extensions
# org.gnome.shell.extensions.system-monitor
gsettings set org.gnome.shell.extensions.system-monitor show-cpu false
gsettings set org.gnome.shell.extensions.system-monitor show-memory false
gsettings set org.gnome.shell.extensions.system-monitor show-swap false
gsettings set org.gnome.shell.extensions.system-monitor show-upload true
gsettings set org.gnome.shell.extensions.system-monitor show-download true
# org.gnome.shell.extensions.workspace-indicator
gsettings set org.gnome.shell.extensions.workspace-indicator embed-previews false
## ========================================================================== ##


#gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
# Make Dock Transparent
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.5
# Icon Size in Dock
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 38
# Workspace Mode (Dynamic or Fixed Number)
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5
gsettings set org.gnome.mutter center-new-windows true
# Switch Workspaces with Edge Pressure:
gsettings set org.gnome.shell.overrides edge-tiling true
# Enable Window Tiling and Snapping:
gsettings set org.gnome.mutter edge-tiling true
# Show or Hide Desktop Icons:
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
# Theme:
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-red-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.shell.extensions.user-theme name 'Adwaita'
# Set Gnome's to Default fonts (Adwaita):
gsettings set org.gnome.desktop.interface font-name "Adwaita Sans 11"
gsettings set org.gnome.desktop.interface monospace-font-name "Adwaita Mono 11"
# Reset Gnome to OS's default (e.g. Ubuntu uses Ubuntu Sans and Ubuntu Sans Mono):
#gsettings reset org.gnome.desktop.interface font-name
#gsettings reset org.gnome.desktop.interface monospace-font-name
# Text Scaling Factor:
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
# Laptop Lid Close Behavior (nothing, suspend, hibernate, shutdown):
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'suspend'
# Disable Automatic Suspend on AC Power:
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ audible-bell true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ visible-name 'Effi'
# Sets Font to Cascadia Code 11:
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-system-font false
#gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ font 'Cascadia Code NF 11'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ font 'Source Code Pro 15'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ bold-is-bright true
# Set Terminal Size to 130 Columns and 30 Rows:
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ default-size-columns 150
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ default-size-rows 30
# Disable Theme Colors and Apply Custom Colors:
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ background-color 'rgb(0,0,0)'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ foreground-color 'rgb(255,255,255)'
# Enable Transparency and Set Background Transparency to 0.9 (10% Transparency):
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-theme-transparency false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-transparent-background true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ background-transparency-percent 15
