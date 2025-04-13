#!/bin/bash

sudo dpkg -s curl &> /dev/null                                          || sudo apt install -y curl
# Install GNOME Shell Extensions
sudo dpkg -s gnome-shell-extensions &> /dev/null                        || sudo apt install -y gnome-shell-extensions
sudo dpkg -s gnome-shell-extension-prefs &> /dev/null                   || sudo apt install -y gnome-shell-extension-prefs
sudo dpkg -s gnome-shell-extension-manager &> /dev/null                 || sudo apt install -y gnome-shell-extension-manager
sudo dpkg -s gnome-shell-extension-user-theme &> /dev/null              || sudo apt install -y gnome-shell-extension-user-theme
sudo dpkg -s gnome-shell-extension-system-monitor &> /dev/null          || sudo apt install -y gnome-shell-extension-system-monitor
sudo dpkg -s gnome-shell-extension-desktop-icons-ng &> /dev/null        || sudo apt install -y gnome-shell-extension-desktop-icons-ng
sudo dpkg -s gnome-shell-extension-auto-move-windows &> /dev/null       || sudo apt install -y gnome-shell-extension-auto-move-windows
sudo dpkg -s gnome-shell-extension-launch-new-instance  &> /dev/null    || sudo apt install -y gnome-shell-extension-launch-new-instance 
sudo dpkg -s gnome-shell-extension-screenshot-window-sizer &> /dev/null || sudo apt install -y gnome-shell-extension-screenshot-window-sizer

sudo dpkg -s gnome-shell-extension-blur-my-shell &> /dev/null           || sudo apt install -y gnome-shell-extension-blur-my-shell
sudo dpkg -s gnome-shell-extension-easyscreencast &> /dev/null          || sudo apt install -y gnome-shell-extension-easyscreencast 
sudo dpkg -s gnome-shell-extension-weather &> /dev/null                 || sudo apt install -y gnome-shell-extension-weather

sudo dpkg -s gnome-shell-extension-workspace-indicator &> /dev/null     || sudo apt install -y gnome-shell-extension-workspace-indicator
sudo dpkg -s gnome-shell-extension-dash-to-dock &> /dev/null            || sudo apt install -y gnome-shell-extension-dash-to-dock
sudo dpkg -s gnome-shell-extension-places-menu &> /dev/null             || sudo apt install -y gnome-shell-extension-places-menu
sudo dpkg -s gnome-shell-extension-light-style &> /dev/null             || sudo apt install -y gnome-shell-extension-light-style
sudo dpkg -s gnome-shell-extension-drive-menu &> /dev/null              || sudo apt install -y gnome-shell-extension-drive-menu
sudo dpkg -s gnome-shell-extension-apps-menu &> /dev/null               || sudo apt install -y gnome-shell-extension-apps-menu
sudo dpkg -s gnome-browser-connector &> /dev/null                       || sudo apt install -y gnome-browser-connector
sudo dpkg -s gnome-tweaks &> /dev/null                                  || sudo apt install -y gnome-tweaks 
#sudo dpkg -s  &> /dev/null            || sudo apt install -y 


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