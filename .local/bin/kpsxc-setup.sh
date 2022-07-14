#!/usr/bin/env bash
# KeePassXC
# Manual move to workspace 8
# don't bind KeePassXC windows to workspace 8 so that Alt+K floating window
# can appear on workspace of login that we want to use

PROGRAM_NAME="KeePassXC"
WORKSPACE="8"
I3_DESKTOP="i3"

keepassxc &
if [ "$XDG_CURRENT_DESKTOP" = "$I3_DESKTOP" ]; then
    found_program=""
    while [ -z "$found_program" ]
    do
        #check for program
        found_program=$(wmctrl -l | grep $PROGRAM_NAME)
        sleep 1
    done
    i3-msg [class=$PROGRAM_NAME] focus
    i3-msg move container to workspace number $WORKSPACE
fi
