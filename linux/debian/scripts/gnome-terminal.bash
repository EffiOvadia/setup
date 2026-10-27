#!/usr/bin/env bash

set -euo pipefail

# Find the default GNOME Terminal profile.
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
PROFILE_SCHEMA="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${PROFILE_ID}/"
set_gnome() { gsettings set "$PROFILE_SCHEMA" "$1" "$2"; }

PROFILE_KEYS=$(gsettings list-keys "$PROFILE_SCHEMA")
set_if_supported() { if grep -Fxq "$1" <<< "$PROFILE_KEYS"; then set_gnome "$1" "$2"; else printf 'Skipping unsupported setting: %s\n' "$1" >&2; fi; }

# Profile name and terminal bell.
set_gnome visible-name 'Effi'
set_gnome audible-bell true
# Font: keep the comma to select the explicit ExtraLight family.
set_gnome use-system-font false
set_gnome font 'Cascadia Code NF Light, 15'
set_gnome bold-is-bright true
# Initial terminal size: 150 columns × 30 rows.
set_gnome default-size-columns 150
set_gnome default-size-rows 30
# White text on a black background.
set_gnome use-theme-colors false
set_gnome background-color 'rgb(0,0,0)'
set_gnome foreground-color 'rgb(255,255,255)'
# Background transparency: 15% transparent (85% opaque).
set_if_supported use-theme-transparency false
set_if_supported use-transparent-background true
set_if_supported background-transparency-percent 15