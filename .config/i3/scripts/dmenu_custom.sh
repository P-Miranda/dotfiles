#!/usr/bin/env bash
# try to source HOME/.profile before running dmenu_run script

if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi
dmenu_run
