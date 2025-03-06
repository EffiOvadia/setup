#!/usr/bin/env bash

# Create a rule to execute a script when a bluetooth device is connected or disconnected
echo 'ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/etc/scripts/bt_audiocast.sh"' > /etc/udev/rules.d/99-bluetooth.rules
chown root:sudo /etc/udev/rules.d/99-bluetooth.rules
chmod 644 /etc/udev/rules.d/99-bluetooth.rules
# Install bluez & pulseaudio-utils if not installed
dpkg -s bluez            &> /dev/null || apt install --assume-yes bluez
dpkg -s pulseaudio-utils &> /dev/null || apt install --assume-yes pulseaudio-utils
# Create folder for scripts if not exists
[ ! -d /etc/scripts/ ] && mkdir -p /etc/scripts/
# Create a script to combine all audio sinks into a single sink
\cat > /etc/scripts/bt_audiocast.sh <<-'EOF'
#!/usr/bin/env bash
function audiocast()  # Combine all sinks into a single sink
  {
    local combined_sink="Audio-Cast"
    # Unload any existing "module-combine-sink" modules
    local existing_module=$(pactl list short modules | grep -oP '^\d+(?=.*module-combine-sink)')
    [ -n "$existing_module" ] && echo "$existing_module" | xargs -n 1 pactl unload-module
    # Gather all sink names except $combined_sink itself
    local sinks_list=$(pactl list short sinks | awk '$2 != "'$combined_sink'" {print $2}')
    # If there's only one sink, skip combining and return
    [ $(wc -l <<< "$sinks_list") -lt 2 ] && return 1
    # Turn all sink names into a single comma-separated string
    local sinks=$(paste -sd "," <<< "$sinks_list")
    # Load a new combine-sink module using all available sinks
    pactl load-module module-combine-sink sink_name=$combined_sink slaves="$sinks"
    # Make the new combined sink the default sink for all new streams
    pactl set-default-sink "$combined_sink" || return 1
  }
audiocast
EOF
# Make the script executable
chmod 555 /etc/scripts/bt_audiocast.sh
# Reload the udev rules to apply changes
udevadm control --reload-rules
