#!/usr/bin/env bash
# dmenu script to toggle between microphone devices
pactl list short sources |\
    awk {'printf "%s: %s\n", $1, $2'} |\
    dmenu -l 10 |\
    awk {'print $2'} |\
    xargs -I {} pactl set-default-source "{}"
