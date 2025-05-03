#!/usr/bin/env bash

# Custom script to open a URL in a browser of your choice
# 1. Create ~/.local/share/applications/choose-browser.desktop file:
#    [Desktop Entry]
#    Name=Choose Browser
#    Comment=Choose which browser opens url
#    Exec=choose-browser.sh %u
#    Type=Application
#    Category=WebBrowser;
#
# 2. Set as default browser:
# xdg-settings set default-web-browser choose-browser.desktop

url=$1
# firefox
choice_str+="firefox --new-tab --url $url"$'\n'
# brave
choice_str+="brave-browser --app-url $url"$'\n'
# chrome
choice_str+="google-chrome $url"$'\n'
echo "$choice_str" |\
    dmenu -l 10 |
    xargs -I {} bash -c "{}"
