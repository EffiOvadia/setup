#!/usr/bin/env bash

snap install skype
snap install p3x-onenote
snap install zoom-client
snap install rpi-imager
snap install brackets --classic



sudo \cat > /etc/apt/preferences.d/nosnap.pref <<-EOF
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

