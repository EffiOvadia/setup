#!/usr/bin/env bash

#nala install --assume-yes pipewire pipewire-audio-client-libraries pulseaudio pulseaudio-utils 

function Audio-Cast()  # Combine all sinks into a single sink
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

Audio-Cast
#pactl list sinks short