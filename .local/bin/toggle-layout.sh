#!/usr/bin/env bash
# dmenu script to toggle between keyboard layouts
options="setxkbmap -layout pt
setxkbmap -layout us -variant intl"

set_kb_cmd=`echo -e "$options" |\
    dmenu -l 10`

$set_kb_cmd
