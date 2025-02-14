#!/bin/bash

# Uninstall all unused FlatPak apps
flatpak uninstall -y --unused

# Completly uninstall FlatPak and all installed FlatPak Apps
sudo apt remove -y --autoremove flatpak && sudo apt purge -y flatpak