#!/usr/bin/env bash

# Install required packages if missing
sudo dpkg -s bluez            &>/dev/null || sudo apt install -y bluez
sudo dpkg -s pulseaudio-utils &>/dev/null || sudo apt install -y pulseaudio-utils
# Ensure script folder exists
sudo mkdir -p /etc/scripts/
# Create simplified audio combine script
sudo tee /etc/scripts/bt_audiocast.sh > /dev/null <<'EOF'
#!/usr/bin/env bash

combined_sink="Audio-Cast"
existing_module=$(pactl list short modules | grep -oP '^\d+(?=.*module-combine-sink)')
[ -n "$existing_module" ] && echo "$existing_module" | xargs -n 1 pactl unload-module
sinks_list=$(pactl list short sinks | awk -v cs="$combined_sink" '$2 != cs {print $2}')
[ "$(wc -l <<< "$sinks_list")" -lt 2 ] && exit 1
sinks=$(paste -sd "," <<< "$sinks_list")

pactl load-module module-combine-sink sink_name="$combined_sink" slaves="$sinks"
pactl set-default-sink "$combined_sink"
EOF

# Make it executable
sudo chmod +x /etc/scripts/bt_audiocast.sh
# Create udev rule
echo 'ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/bin/su avraham -c \"/etc/scripts/bt_audiocast.sh\""' | \
  sudo tee /etc/udev/rules.d/99-bluetooth.rules > /dev/null
# Set permissions
sudo chmod 644 /etc/udev/rules.d/99-bluetooth.rules
# Reload and apply udev rules
sudo udevadm control --reload
sudo udevadm trigger