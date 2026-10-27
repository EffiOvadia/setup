#!/usr/bin/env bash

set -euo pipefail
command -v gsettings >/dev/null || { echo 'gsettings is required.' >&2; exit 1; }

declare -A schema_dirs=()
resolve_schema() {
    local schema=$1 directory
    if [[ ${schema_dirs[$schema]+found} ]]; then return; fi
    if gsettings list-schemas | grep -Fx "$schema" >/dev/null || gsettings list-relocatable-schemas | grep -Fx "$schema" >/dev/null; then
        schema_dirs[$schema]=''
        return
    fi
    for directory in "${XDG_DATA_HOME:-$HOME/.local/share}"/gnome-shell/extensions/*/schemas /usr/local/share/gnome-shell/extensions/*/schemas /usr/share/gnome-shell/extensions/*/schemas; do
        [[ -f "$directory/gschemas.compiled" ]] || continue
        if gsettings --schemadir "$directory" list-schemas | grep -Fx "$schema" >/dev/null || gsettings --schemadir "$directory" list-relocatable-schemas | grep -Fx "$schema" >/dev/null; then
            schema_dirs[$schema]=$directory
            return
        fi
    done
    schema_dirs[$schema]=MISSING
}

set_gnome() {
    local target=$1 key=$2 value=$3 schema=${1%%:*}
    local -a options=()
    resolve_schema "$schema"
    if [[ ${schema_dirs[$schema]} == MISSING ]]; then
        printf 'Skipping missing schema: %s\n' "$schema" >&2
        return
    fi
    [[ -z ${schema_dirs[$schema]} ]] || options=(--schemadir "${schema_dirs[$schema]}")
    if ! gsettings "${options[@]}" list-keys "$target" | grep -Fx "$key" >/dev/null; then
        printf 'Skipping missing key: %s %s\n' "$target" "$key" >&2
        return
    fi
    gsettings "${options[@]}" set "$target" "$key" "$value"
}


# com.ftpix.transparentbar
set_gnome com.ftpix.transparentbar transparency 50

# org.gnome.desktop.a11y
set_gnome org.gnome.desktop.a11y always-show-universal-access-status true

# org.gnome.desktop.app-folders
set_gnome org.gnome.desktop.app-folders folder-children "['Utilities', 'YaST', 'Pardus']"

# org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Pardus/
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Pardus/ categories "['X-Pardus-Apps']"
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Pardus/ name "'X-Pardus-Apps.directory'"
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Pardus/ translate true

# org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ apps "['gnome-abrt.desktop', 'gnome-system-log.desktop', 'nm-connection-editor.desktop', 'org.gnome.baobab.desktop', 'org.gnome.Connections.desktop', 'org.gnome.DejaDup.desktop', 'org.gnome.Dictionary.desktop', 'org.gnome.DiskUtility.desktop', 'org.gnome.Evince.desktop', 'org.gnome.FileRoller.desktop', 'org.gnome.fonts.desktop', 'org.gnome.Loupe.desktop', 'org.gnome.seahorse.Application.desktop', 'org.gnome.tweaks.desktop', 'org.gnome.Usage.desktop', 'vinagre.desktop']"
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ categories "['X-GNOME-Utilities']"
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ name "'X-GNOME-Utilities.directory'"
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ translate true

# org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/YaST/
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/YaST/ categories "['X-SuSE-YaST']"
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/YaST/ name "'suse-yast.directory'"
set_gnome org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/YaST/ translate true

# org.gnome.desktop.background
set_gnome org.gnome.desktop.background picture-uri "'file:///home/effio/.local/share/backgrounds/2024-12-20-19-18-19-effi.ovadia_A_blue_misty_forest_shot_from_a_low_angle_in_the_st_7a6f1de9-fe56-4826-ae18-fd2871f424e6.png'"
set_gnome org.gnome.desktop.background picture-uri-dark "'file:///home/effio/.local/share/backgrounds/2024-12-20-19-18-19-effi.ovadia_A_blue_misty_forest_shot_from_a_low_angle_in_the_st_7a6f1de9-fe56-4826-ae18-fd2871f424e6.png'"
set_gnome org.gnome.desktop.background primary-color "'#000000000000'"
set_gnome org.gnome.desktop.background secondary-color "'#000000000000'"
set_gnome org.gnome.desktop.background show-desktop-icons false

# org.gnome.desktop.calendar
set_gnome org.gnome.desktop.calendar show-weekdate true

# org.gnome.desktop.datetime
set_gnome org.gnome.desktop.datetime automatic-timezone true

# org.gnome.desktop.input-sources
set_gnome org.gnome.desktop.input-sources mru-sources "[('xkb', 'us'), ('xkb', 'il')]"
set_gnome org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'il')]"

# org.gnome.desktop.interface
set_gnome org.gnome.desktop.interface clock-show-seconds true
set_gnome org.gnome.desktop.interface clock-show-weekday true
set_gnome org.gnome.desktop.interface color-scheme "'prefer-dark'"
set_gnome org.gnome.desktop.interface cursor-theme "'Adwaita'"
set_gnome org.gnome.desktop.interface font-hinting "'full'"
set_gnome org.gnome.desktop.interface font-name "'Ubuntu Sans 11'"
set_gnome org.gnome.desktop.interface gtk-theme "'Yaru-prussiangreen-dark'"
set_gnome org.gnome.desktop.interface icon-theme "'Yaru-prussiangreen'"
set_gnome org.gnome.desktop.interface monospace-font-name "'Ubuntu Sans Mono 13'"
set_gnome org.gnome.desktop.interface text-scaling-factor 1.0

# org.gnome.desktop.notifications
set_gnome org.gnome.desktop.notifications application-children "['org-gnome-texteditor', 'com-discordapp-discord', 'thunderbird', 'org-gnome-nautilus', 'eu-betterbird-betterbird', 'org-gnome-software', 'org-gnome-terminal-preferences', 'org-gnome-extensions', 'org-gnome-settings', 'org-gnome-tweaks', 'org-darktable-darktable', 'org-gnome-evolution', 'com-microsoft-teams', 'firefox', 'org-gnome-characters', 'apport-gtk', 'gparted', 'rxvt-unicode', 'org-wezfurlong-wezterm', 'emacs', 'gvim', 'io-github-shiftey-desktop', 'guake', 'solaar', 'mullvad-vpn', 'org-gnome-dejadup', 'code', 'tabby', 'rustdesk', 'chatgpt', 'org-gnome-terminal', 'grok-bot', 'brave-browser', 'com-microsoft-vscode', 'chromium-browser', 'cursor', 'com-visualstudio-codeoss', 'com-mitchellh-ghostty', 'update-manager']"
set_gnome org.gnome.desktop.notifications show-in-lock-screen false

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/apport-gtk/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/apport-gtk/ application-id "'apport-gtk.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/brave-browser/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/brave-browser/ application-id "'brave-browser.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/chatgpt/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/chatgpt/ application-id "'chatgpt.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/chromium-browser/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/chromium-browser/ application-id "'chromium-browser.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/code/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/code/ application-id "'code.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-discordapp-discord/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-discordapp-discord/ application-id "'com.discordapp.Discord.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-microsoft-teams/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-microsoft-teams/ application-id "'com.microsoft.Teams.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-microsoft-vscode/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-microsoft-vscode/ application-id "'com.microsoft.VSCode.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-mitchellh-ghostty/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-mitchellh-ghostty/ application-id "'com.mitchellh.ghostty.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-visualstudio-codeoss/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/com-visualstudio-codeoss/ application-id "'com.visualstudio.CodeOSS.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/cursor/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/cursor/ application-id "'cursor.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/emacs/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/emacs/ application-id "'emacs.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/eu-betterbird-betterbird/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/eu-betterbird-betterbird/ application-id "'eu.betterbird.Betterbird.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/firefox/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/firefox/ application-id "'firefox.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/gparted/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/gparted/ application-id "'gparted.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/grok-bot/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/grok-bot/ application-id "'grok-bot.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/guake/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/guake/ application-id "'guake.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/gvim/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/gvim/ application-id "'gvim.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/io-github-shiftey-desktop/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/io-github-shiftey-desktop/ application-id "'io.github.shiftey.Desktop.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/mullvad-vpn/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/mullvad-vpn/ application-id "'mullvad-vpn.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-darktable-darktable/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-darktable-darktable/ application-id "'org.darktable.darktable.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-characters/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-characters/ application-id "'org.gnome.Characters.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-dejadup/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-dejadup/ application-id "'org.gnome.DejaDup.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-evolution/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-evolution/ application-id "'org.gnome.Evolution.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-extensions/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-extensions/ application-id "'org.gnome.Extensions.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-nautilus/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-nautilus/ application-id "'org.gnome.Nautilus.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-settings/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-settings/ application-id "'org.gnome.Settings.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-software/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-software/ application-id "'org.gnome.Software.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-terminal-preferences/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-terminal-preferences/ application-id "'org.gnome.Terminal.Preferences.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-terminal/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-terminal/ application-id "'org.gnome.Terminal.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-texteditor/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-texteditor/ application-id "'org.gnome.TextEditor.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-tweaks/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-gnome-tweaks/ application-id "'org.gnome.tweaks.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-wezfurlong-wezterm/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/org-wezfurlong-wezterm/ application-id "'org.wezfurlong.wezterm.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/rustdesk/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/rustdesk/ application-id "'rustdesk.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/rxvt-unicode/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/rxvt-unicode/ application-id "'rxvt-unicode.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/solaar/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/solaar/ application-id "'solaar.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/tabby/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/tabby/ application-id "'tabby.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/thunderbird/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/thunderbird/ application-id "'thunderbird.desktop'"

# org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/update-manager/
set_gnome org.gnome.desktop.notifications.application:/org/gnome/desktop/notifications/application/update-manager/ application-id "'update-manager.desktop'"

# org.gnome.desktop.privacy
set_gnome org.gnome.desktop.privacy old-files-age 'uint32 1'
set_gnome org.gnome.desktop.privacy remove-old-temp-files true
set_gnome org.gnome.desktop.privacy remove-old-trash-files true

# org.gnome.desktop.screensaver
set_gnome org.gnome.desktop.screensaver lock-enabled false
set_gnome org.gnome.desktop.screensaver picture-uri "'file:///home/effio/.local/share/backgrounds/2024-12-20-19-18-19-effi.ovadia_A_blue_misty_forest_shot_from_a_low_angle_in_the_st_7a6f1de9-fe56-4826-ae18-fd2871f424e6.png'"
set_gnome org.gnome.desktop.screensaver primary-color "'#000000000000'"
set_gnome org.gnome.desktop.screensaver secondary-color "'#000000000000'"
set_gnome org.gnome.desktop.screensaver ubuntu-lock-on-suspend false

# org.gnome.desktop.search-providers
set_gnome org.gnome.desktop.search-providers sort-order "['org.gnome.Settings.desktop', 'org.gnome.Contacts.desktop', 'org.gnome.Nautilus.desktop']"

# org.gnome.desktop.session
set_gnome org.gnome.desktop.session idle-delay 'uint32 0'

# org.gnome.desktop.wm.keybindings
set_gnome org.gnome.desktop.wm.keybindings maximize '@as []'
set_gnome org.gnome.desktop.wm.keybindings unmaximize '@as []'

# org.gnome.desktop.wm.preferences
set_gnome org.gnome.desktop.wm.preferences button-layout "':close'"
set_gnome org.gnome.desktop.wm.preferences num-workspaces 5

# org.gnome.mutter
set_gnome org.gnome.mutter center-new-windows true
set_gnome org.gnome.mutter dynamic-workspaces false
set_gnome org.gnome.mutter edge-tiling false

# org.gnome.mutter.keybindings
set_gnome org.gnome.mutter.keybindings toggle-tiled-left '@as []'
set_gnome org.gnome.mutter.keybindings toggle-tiled-right '@as []'

# org.gnome.nautilus.icon-view
set_gnome org.gnome.nautilus.icon-view default-zoom-level "'medium'"

# org.gnome.nautilus.preferences
set_gnome org.gnome.nautilus.preferences migrated-gtk-settings true

# org.gnome.settings-daemon.plugins.color
set_gnome org.gnome.settings-daemon.plugins.color night-light-temperature 'uint32 4700'

# org.gnome.settings-daemon.plugins.power
set_gnome org.gnome.settings-daemon.plugins.power idle-dim false
set_gnome org.gnome.settings-daemon.plugins.power lid-close-ac-action "'suspend'"
set_gnome org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
set_gnome org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "'nothing'"

# org.gnome.shell
set_gnome org.gnome.shell app-picker-layout "[{'org.gnome.Geary.desktop': <{'position': <0>}>, 'software-properties-drivers.desktop': <{'position': <1>}>, 'org.gnome.clocks.desktop': <{'position': <2>}>, 'ksh93.desktop': <{'position': <3>}>, 'btop.desktop': <{'position': <4>}>, 'ddrescueview.desktop': <{'position': <5>}>, 'deluge.desktop': <{'position': <6>}>, 'org.gnome.Calculator.desktop': <{'position': <7>}>, 'org.gnome.Extensions.desktop': <{'position': <8>}>, 'org.gnome.Settings.desktop': <{'position': <9>}>, 'org.gnome.SystemMonitor.desktop': <{'position': <10>}>, 'filezilla.desktop': <{'position': <11>}>, 'Utilities': <{'position': <12>}>, 'fish.desktop': <{'position': <13>}>, 'yelp.desktop': <{'position': <14>}>, 'guake-prefs.desktop': <{'position': <15>}>, 'guake.desktop': <{'position': <16>}>, 'htop.desktop': <{'position': <17>}>, 'org.gabmus.hydrapaper.desktop': <{'position': <18>}>, 'org.gnome.eog.desktop': <{'position': <19>}>, 'org.gnome.Totem.desktop': <{'position': <20>}>, 'Helix.desktop': <{'position': <21>}>, 'nvim.desktop': <{'position': <22>}>, 'vim.desktop': <{'position': <23>}>}, {'display-im6.q16.desktop': <{'position': <0>}>, 'org.keepassxc.KeePassXC.desktop': <{'position': <1>}>, 'org.kde.kleopatra.desktop': <{'position': <2>}>, 'gnome-language-selector.desktop': <{'position': <3>}>, 'libreoffice-startcenter.desktop': <{'position': <4>}>, 'org.gnome.Calendar.desktop': <{'position': <5>}>, 'libreoffice-calc.desktop': <{'position': <6>}>, 'libreoffice-draw.desktop': <{'position': <7>}>, 'libreoffice-impress.desktop': <{'position': <8>}>, 'libreoffice-math.desktop': <{'position': <9>}>, 'libreoffice-writer.desktop': <{'position': <10>}>, 'org.gnome.Snapshot.desktop': <{'position': <11>}>, 'org.gnome.Meld.desktop': <{'position': <12>}>, 'mc.desktop': <{'position': <13>}>, 'com.cloudflare.WarpTaskbar.desktop': <{'position': <14>}>, 'mcedit.desktop': <{'position': <15>}>, 'solaar.desktop': <{'position': <16>}>, 'mutt.desktop': <{'position': <17>}>, 'simple-scan.desktop': <{'position': <18>}>, 'org.gnome.Nautilus.desktop': <{'position': <19>}>, 'org.gnome.gitg.desktop': <{'position': <20>}>, 'org.gnome.PowerStats.desktop': <{'position': <21>}>, 'putty.desktop': <{'position': <22>}>, 'antigravity.desktop': <{'position': <23>}>}, {'org.qbittorrent.qBittorrent.desktop': <{'position': <0>}>, 'org.remmina.Remmina.desktop': <{'position': <1>}>, 'rxvt-unicode.desktop': <{'position': <2>}>, 'org.gnome.Software.desktop': <{'position': <3>}>, 'software-properties-gtk.desktop': <{'position': <4>}>, 'mpv.desktop': <{'position': <5>}>, 'update-manager.desktop': <{'position': <6>}>, 'gnome-session-properties.desktop': <{'position': <7>}>, 'synaptic.desktop': <{'position': <8>}>, 'com.teamviewer.TeamViewer.desktop': <{'position': <9>}>, 'org.gnome.Rhythmbox3.desktop': <{'position': <10>}>, 'org.gnome.TextEditor.desktop': <{'position': <11>}>, 'org.gnome.Shotwell.desktop': <{'position': <12>}>, 'github-desktop.desktop': <{'position': <13>}>, 'transmission-gtk.desktop': <{'position': <14>}>, 'typecatcher.desktop': <{'position': <15>}>, 'kitty.desktop': <{'position': <16>}>, 'org.wireshark.Wireshark.desktop': <{'position': <17>}>, 'mullvad-vpn.desktop': <{'position': <18>}>, 'com.yubico.yubioath.desktop': <{'position': <19>}>, 'ykman-gui.desktop': <{'position': <20>}>, 'NymVPN.desktop': <{'position': <21>}>, 'openlogi.desktop': <{'position': <22>}>, 'tabby.desktop': <{'position': <23>}>}, {'org.wezfurlong.wezterm.desktop': <{'position': <0>}>}]"
set_gnome org.gnome.shell disabled-extensions "['switchWorkSpace@sun.wxg@gmail.com', 'openweather-extension@penguin-teal.github.io', 'window-list@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com', 'solaar-extension@sidevesh', 'system-monitor@gnome-shell-extensions.gcampax.github.com', 'apps-menu@gnome-shell-extensions.gcampax.github.com', 'top-bar-organizer@julian.gse.jsts.xyz']"
set_gnome org.gnome.shell enabled-extensions "['ubuntu-dock@ubuntu.com', 'places-menu@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'extension-list@tu.berry', 'CustomizeClockOnLockScreen@pratap.fastmail.fm', 'Vitals@CoreCoding.com', 'desktop-cube@schneegans.github.com', 'workspace-switcher-manager@G-dH.github.com', 'translate-clipboard@lsnow.github.io', 'transparent-top-bar@ftpix.com', 'nextdns@mysticnico.github.com', 'night-style-monitor@mmoe.work', 'burn-my-windows@schneegans.github.com', 'gravatar@dsheeler.net', 'ding@rastersoft.com', 'windowsNavigator@gnome-shell-extensions.gcampax.github.com', 'tiling-assistant@ubuntu.com', 'native-window-placement@gnome-shell-extensions.gcampax.github.com', 'grayscale-window@cg505.com', 'transparent-window-moving@noobsai.github.com', 'compiz-windows-effect@hermes83.github.com', 'screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com', 'move-date@fthx', 'background-logo@fedorahosted.org', 'blur-my-shell@aunetx', 'dim-background-windows@stephane-13.github.com', 'network-stats@gnome.noroadsleft.xyz', 'dash-to-dock@micxgx.gmail.com', 'auto-move-windows@gnome-shell-extensions.gcampax.github.com', 'light-style@gnome-shell-extensions.gcampax.github.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'launch-new-instance@gnome-shell-extensions.gcampax.github.com', 'system-monitor@jtourteau', 'ubuntu-appindicators@ubuntu.com', 'hide-radio-controls@local', 'wifiqrcode@glerro.pm.me']"
set_gnome org.gnome.shell favorite-apps "['gparted.desktop', 'gvim.desktop', 'org.gnome.Terminal.desktop', 'cursor.desktop', 'grok-bot.desktop', 'chatgpt.desktop', 'com.anthropic.Claude.desktop', 'firefox.desktop', 'vivaldi-stable.desktop', 'brave-browser.desktop', 'chromium-browser.desktop', 'thunderbird.desktop', 'com.microsoft.VSCode.desktop', 'rustdesk.desktop', 'com.visualstudio.CodeOSS.desktop', 'com.mitchellh.ghostty.desktop']"
set_gnome org.gnome.shell welcome-dialog-last-shown-version "'47.0'"

# org.gnome.shell.extensions.blur-my-shell
set_gnome org.gnome.shell.extensions.blur-my-shell pipelines "{'pipeline_default': {'name': <'Default'>, 'effects': <[<{'type': <'dual_kawase_blur'>, 'id': <'effect_000000000000'>, 'params': <{'unscaled_radius': <30>, 'brightness': <0.59999999999999998>}>}>]>}, 'pipeline_migrated_dynamic_blur': {'name': <'Migrated dynamic blur'>, 'effects': <[<{'type': <'dual_kawase_blur'>, 'id': <'effect_migrated_dynamic_blur'>, 'params': <{'unscaled_radius': <60>, 'brightness': <0.59999999999999998>}>}>]>}}"
set_gnome org.gnome.shell.extensions.blur-my-shell settings-version 7

# org.gnome.shell.extensions.blur-my-shell.appfolder
set_gnome org.gnome.shell.extensions.blur-my-shell.appfolder pipeline "'pipeline_migrated_dynamic_blur'"

# org.gnome.shell.extensions.blur-my-shell.dash-to-dock
set_gnome org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 0

# org.gnome.shell.extensions.blur-my-shell.window-list
set_gnome org.gnome.shell.extensions.blur-my-shell.window-list pipeline "'pipeline_migrated_dynamic_blur'"

# org.gnome.shell.extensions.burn-my-windows
set_gnome org.gnome.shell.extensions.burn-my-windows active-profile "'/home/effio/.config/burn-my-windows/profiles/1736480663805862.conf'"
set_gnome org.gnome.shell.extensions.burn-my-windows last-extension-version 44
set_gnome org.gnome.shell.extensions.burn-my-windows prefs-open-count 3

# org.gnome.shell.extensions.com.github.hermes83.compiz-windows-effect
set_gnome org.gnome.shell.extensions.com.github.hermes83.compiz-windows-effect last-version 29
set_gnome org.gnome.shell.extensions.com.github.hermes83.compiz-windows-effect preset "'R'"

# org.gnome.shell.extensions.dash-to-dock
set_gnome org.gnome.shell.extensions.dash-to-dock apply-custom-theme true
set_gnome org.gnome.shell.extensions.dash-to-dock background-opacity 0.59999999999999998
set_gnome org.gnome.shell.extensions.dash-to-dock click-action "'minimize-or-previews'"
set_gnome org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 40
set_gnome org.gnome.shell.extensions.dash-to-dock icon-size-fixed false
set_gnome org.gnome.shell.extensions.dash-to-dock multi-monitor true
set_gnome org.gnome.shell.extensions.dash-to-dock preferred-monitor-by-connector "'DP-1'"
set_gnome org.gnome.shell.extensions.dash-to-dock preview-size-scale 0.29999999999999999
set_gnome org.gnome.shell.extensions.dash-to-dock show-mounts false
set_gnome org.gnome.shell.extensions.dash-to-dock show-mounts-network false
set_gnome org.gnome.shell.extensions.dash-to-dock show-mounts-only-mounted true
set_gnome org.gnome.shell.extensions.dash-to-dock show-trash false
set_gnome org.gnome.shell.extensions.dash-to-dock transparency-mode "'DYNAMIC'"

# org.gnome.shell.extensions.desktop-cube
set_gnome org.gnome.shell.extensions.desktop-cube inactive-workpace-opacity 137
set_gnome org.gnome.shell.extensions.desktop-cube last-first-gap false
set_gnome org.gnome.shell.extensions.desktop-cube window-parallax 0.51587301587301593

# org.gnome.shell.extensions.ding
set_gnome org.gnome.shell.extensions.ding show-home false

# org.gnome.shell.extensions.system-monitor
set_gnome org.gnome.shell.extensions.system-monitor show-cpu false
set_gnome org.gnome.shell.extensions.system-monitor show-download true
set_gnome org.gnome.shell.extensions.system-monitor show-memory false
set_gnome org.gnome.shell.extensions.system-monitor show-swap false
set_gnome org.gnome.shell.extensions.system-monitor show-upload true

# org.gnome.shell.extensions.tiling-assistant
set_gnome org.gnome.shell.extensions.tiling-assistant active-window-hint-color "'rgb(211,70,21)'"
set_gnome org.gnome.shell.extensions.tiling-assistant favorite-layouts "['-1']"
set_gnome org.gnome.shell.extensions.tiling-assistant import-layout-examples false
set_gnome org.gnome.shell.extensions.tiling-assistant last-version-installed 46
set_gnome org.gnome.shell.extensions.tiling-assistant overridden-settings "{'org.gnome.mutter.edge-tiling': <true>, 'org.gnome.mutter.keybindings.toggle-tiled-left': <@mb nothing>, 'org.gnome.mutter.keybindings.toggle-tiled-right': <@mb nothing>}"
set_gnome org.gnome.shell.extensions.tiling-assistant tiling-popup-all-workspace true

# org.gnome.shell.extensions.top-bar-organizer
set_gnome org.gnome.shell.extensions.top-bar-organizer center-box-order "['system-monitor@jtourteau']"
set_gnome org.gnome.shell.extensions.top-bar-organizer hide "['apps-menu']"
set_gnome org.gnome.shell.extensions.top-bar-organizer left-box-order "['activities', 'workspace-indicator', 'places-menu', 'apps-menu']"
set_gnome org.gnome.shell.extensions.top-bar-organizer right-box-order "['appindicator-kstatusnotifieritem-tray-icon tray app rustdesk', 'appindicator-kstatusnotifieritem-Claude_status_icon_1', 'appindicator-kstatusnotifieritem-Mullvad VPN_status_icon_1', 'appindicator-kstatusnotifieritem-un-reboot', 'appindicator-kstatusnotifieritem-chrome_status_icon_1', 'improved-workspace-indicator', 'appindicator-kstatusnotifieritem-livepatch', 'appindicator-kstatusnotifieritem-zero-trust-client', 'NetworkStatsStatusView', 'netspeed@alynx.one', 'netspeedindicator@subashghimire.info.np', 'appindicator-kstatusnotifieritem-z7_UvU5qQ-', 'appindicator-kstatusnotifieritem-9tMmLEoDQZ', 'appindicator-kstatusnotifieritem-ky5xiMwO16', 'appindicator-kstatusnotifieritem-SimpleScreenRecorder', 'appindicator-kstatusnotifieritem-software-update-available', 'appindicator-kstatusnotifieritem-indicator-solaar', 'drive-menu', 'tiling-assistant@leleat-on-github', 'extension-list@tu.berry', 'screenRecording', 'screenSharing', 'dwellClick', 'a11y', 'keyboard', 'system-monitor@gnome-shell-extensions.gcampax.github.com', 'dateMenu', 'quickSettings']"

# org.gnome.shell.extensions.transparent-window-moving
set_gnome org.gnome.shell.extensions.transparent-window-moving window-opacity 200

# org.gnome.shell.extensions.user-theme
set_gnome org.gnome.shell.extensions.user-theme name "''"

printf 'GNOME settings applied; review any skipped settings above.\n'
