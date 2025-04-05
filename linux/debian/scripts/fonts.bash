#!/bin/bash

## =============================================
# Determine latest release
LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/microsoft/cascadia-code/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4)
# Check if the URL is not empty and download the font
if [[ -n "$LATEST_RELEASE_URL" ]]; then
  # Create temporary directory
  TEMP_DIR=$(mktemp -d) && cd "$TEMP_DIR"
  # Download the font
  wget -q --show-progress "$LATEST_RELEASE_URL" -O cascadia.zip
  # Unzip the font files
  unzip -q cascadia.zip
  # Create font directory if it doesn't exist
  FONT_DIR="/usr/share/fonts/truetype/cascadia"
  mkdir -p "$FONT_DIR"
  # Install the fonts
  cp -f ttf/static/*.ttf "$FONT_DIR/"
  # Update font cache
  fc-cache
  # Clean up
  [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]] && rm -rf "$TEMP_DIR"
fi
## ============================================
# Determine latest release
LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/adobe-fonts/source-code-pro/releases/latest | grep "browser_download_url.*TTF.*zip" | cut -d '"' -f 4)
# Check if the URL is not empty and download the font
if [[ -n "$LATEST_RELEASE_URL" ]]; then
  # Create temporary directory
  TEMP_DIR=$(mktemp -d) && cd "$TEMP_DIR"
  # Download the font
  wget -q --show-progress "$LATEST_RELEASE_URL" -O source-code-pro.zip
  # Unzip the font files
  unzip -q source-code-pro.zip
  # Create font directory if it doesn't exist
  FONT_DIR="/usr/share/fonts/truetype/source-code-pro"
  mkdir -p "$FONT_DIR"
  # Install the fonts
  [ -d "TTF" ] && cp -f TTF/*.ttf "$FONT_DIR/"
  # Update font cache
  fc-cache -f
  # Clean up
  [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]] && rm -rf "$TEMP_DIR"
fi
## ============================================
# Determine latest release
LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/be5invis/Iosevka/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4 | head -1)
# Check if the URL is not empty and download the font
if [[ -n "$LATEST_RELEASE_URL" ]]; then
  # Create temporary directory
  TEMP_DIR=$(mktemp -d) && cd "$TEMP_DIR"
  # Download the font
  wget -q --show-progress "$LATEST_RELEASE_URL" -O iosevka.zip
  # Unzip the font files
  unzip -q iosevka.zip
  # Create font directory if it doesn't exist
  FONT_DIR="/usr/share/fonts/truetype/iosevka"
  mkdir -p "$FONT_DIR"
  # Install the fonts
  cp -f *.ttc "$FONT_DIR/"
  # Update font cache
  fc-cache
  # Clean up
  [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]] && rm -rf "$TEMP_DIR"
fi
## ============================================
fc-list | grep -i "Cascadia"
fc-list | grep -i "SourceCodePro"
fc-list | grep -i "Iosevka"

