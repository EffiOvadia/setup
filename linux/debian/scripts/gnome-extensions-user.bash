#!/usr/bin/env bash

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
