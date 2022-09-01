#!/usr/bin/env bash
# dmenu script to toggle between playback devices
pactl list short sinks |\
    awk {'printf "%s: %s\n", $1, $2'} |\
    dmenu -l 10 |\
    awk {'print $2'} |\
    xargs -I {} pactl set-default-sink "{}"
