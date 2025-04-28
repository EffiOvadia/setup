#!/bin/bash

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
sudo dpkg -s gnome-shell-extension-workspace-indicator &> /dev/null     || sudo apt install -y gnome-shell-extension-workspace-indicator
sudo dpkg -s gnome-shell-extension-places-menu &> /dev/null             || sudo apt install -y gnome-shell-extension-places-menu
sudo dpkg -s gnome-shell-extension-light-style &> /dev/null             || sudo apt install -y gnome-shell-extension-light-style
sudo dpkg -s gnome-shell-extension-drive-menu &> /dev/null              || sudo apt install -y gnome-shell-extension-drive-menu
sudo dpkg -s gnome-shell-extension-apps-menu &> /dev/null               || sudo apt install -y gnome-shell-extension-apps-menu
sudo dpkg -s gnome-browser-connector &> /dev/null                       || sudo apt install -y gnome-browser-connector
sudo dpkg -s gnome-tweaks &> /dev/null                                  || sudo apt install -y gnome-tweaks 
sudo dpkg -s hydrapaper &> /dev/null                                    || sudo apt install -y hydrapaper 
