#!/usr/bin/env bash

sudo add-apt-repository universe
sudo apt install libfuse2t64


## example ::

# Install Joplin via the AppImage (no official repository)
wget -O joplin.AppImage https://github.com/laurent22/joplin/releases/latest/download/Joplin-x86_64.AppImage
chmod +x joplin.AppImage

# Move to a better location
sudo mkdir -p /opt/joplin
sudo mv joplin.AppImage /opt/joplin/Joplin.AppImage

# Create desktop shortcut
cat << EOF | sudo tee /usr/share/applications/joplin.desktop
[Desktop Entry]
Name=Joplin
Comment=Joplin note-taking app
Exec=/opt/joplin/Joplin.AppImage
Icon=joplin
Type=Application
Categories=Office;
EOF