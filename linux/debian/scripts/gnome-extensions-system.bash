#!/usr/bin/env bash
set -euo pipefail

SUDO=() ; (( EUID == 0 )) || SUDO=(sudo)

packages=(
            gnome-shell-extensions
            gnome-shell-extension-prefs
            gnome-shell-extension-manager
            gnome-shell-extension-user-theme
            gnome-shell-extension-system-monitor
            gnome-shell-extension-desktop-icons-ng
            gnome-shell-extension-auto-move-windows
            gnome-shell-extension-launch-new-instance
            gnome-shell-extension-screenshot-window-sizer
            gnome-shell-extension-workspace-indicator
            gnome-shell-extension-places-menu
            gnome-shell-extension-light-style
            gnome-shell-extension-drive-menu
            gnome-shell-extension-apps-menu
            gnome-browser-connector
            gnome-tweaks
            hydrapaper
        )

has_candidate() { LC_ALL=C apt-cache policy "$1" | awk '$1 == "Candidate:" && $2 != "(none)" { found=1 } END { exit !found }'; }

"${SUDO[@]}" apt-get update

available=()
unavailable=()

for package in "${packages[@]}"; do
    if has_candidate "$package"; then available+=("$package"); else unavailable+=("$package"); fi
done

if ((${#available[@]})); then "${SUDO[@]}" apt-get install -y --no-upgrade "${available[@]}"; fi
if ((${#unavailable[@]})); then printf '\nUnavailable in enabled repositories:\n'; printf '  %s\n' "${unavailable[@]}"; fi
