#!/usr/bin/env bash

#apps=( pipewire pipewire-audio-client-libraries pulseaudio pulseaudio-utils )
#install ${apps[@]}

#pactl list sinks short

function combine_sinks() 
{
  # Unload any existing "module-combine-sink" modules
  pactl list short modules | awk '/module-combine-sink/ {system("pactl unload-module " $1)}'
  # Gather all sink names except "AVRAHAM-Combined-Sink"
  SINKS_LIST="$(pactl list short sinks | awk '$2 != "AVRAHAM-Combined-Sink" {print $2}')"
  NUM_SINKS="$(echo "$SINKS_LIST" | wc -l)"
  # If there's only one sink, skip combining
  [ "$NUM_SINKS" -lt 2 ] && return 1
  # Turn all sink names into a single comma-separated string
  SINKS="$(echo "$SINKS_LIST" | paste -sd "," -)"
  # Load a new combine-sink module using all available sinks
  pactl load-module module-combine-sink sink_name=AVRAHAM-Combined-Sink slaves="$SINKS"
  # Make the new combined sink the default
  pactl set-default-sink AVRAHAM-Combined-Sink
  # Return the name of the new combined sink
  pactl list short modules | awk -F 'sink_name=| ' '/combine-sink/ {print $3}'
}

combine_sinks