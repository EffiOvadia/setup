#!/bin/bash

### ! Adding AppImages applications
mkdir -p ~/AppImages && cd ~/AppImages
###  Rambox
###  https://github.com/ramboxapp/community-edition/releases/latest
wget https://github.com/ramboxapp/community-edition/releases/download/0.7.6/Rambox-0.7.6-linux-x86_64.AppImage
###  Zoom
###  https://github.com/probonopd/Zoom.AppImage/releases/latest
wget https://github.com/probonopd/Zoom.AppImage/releases/download/stable/Zoom-5.3.465578.0920.glibc2.17-x86_64.AppImage
###  Discord
###  https://github.com/srevinsaju/discord-appimage/releases/latest
wget https://github.com/srevinsaju/discord-appimage/releases/download/stable/Discord-0.0.12-x86_64.AppImage
###  Firefox
###  https://github.com/srevinsaju/Firefox-Appimage/releases/latest
wget https://github.com/srevinsaju/Firefox-Appimage/releases/download/stable/Firefox-81.0_20200930150533-x86_64.AppImage
###  Thunderbird
###  https://github.com/srevinsaju/thunderbird-appimage/releases/latest
wget https://github.com/srevinsaju/thunderbird-appimage/releases/download/stable/Thunderbird-78.3_20200925001233.AppImage
###  OneNote
###  https://github.com/patrikx3/onenote/releases/latest
wget https://github.com/patrikx3/onenote/releases/download/v2020.10.132/P3X-OneNote-2020.10.132.AppImage
###  OnlyOffice
###  https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/latest
wget https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/download/v5.6.4/DesktopEditors-x86_64.AppImage
###  Outline Server
###  https://github.com/Jigsaw-Code/outline-server/releases/latest
wget https://github.com/Jigsaw-Code/outline-server/releases/download/server-2020-10-04/Outline-Manager.AppImage
###  Shadowsocks
###  https://github.com/shadowsocks/shadowsocks-qt5/releases/latest
wget https://github.com/shadowsocks/shadowsocks-qt5/releases/download/v3.0.1/Shadowsocks-Qt5-3.0.1-x86_64.AppImage
###  Elctron WeChat
###  https://github.com/eNkru/freechat/releases/latest
wget https://github.com/eNkru/freechat/releases/download/v1.0.0/electron-wechat-1.0.0-x86_64.AppImage
###  Qbittorrent
###  https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest
wget https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/download/release-4.2.5.16/qBittorrent-Enhanced-Edition.AppImage
###  Rufus
###  https://github.com/ukinoki/Rufus/releases/latest
wget https://github.com/ukinoki/Rufus/releases/download/continuous/Rufus-294d3be-x86_64.AppImage

chmod a+x *.AppImage