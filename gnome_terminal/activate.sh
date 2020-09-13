#! /usr/bin/env bash

if [ $(uname 2>&1) = "Darwin" ]; then
    # macOS
    echo "gnome terminal config update: skipped"
    exit
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

echo "update gnome-terminal configs"
dconf reset -f /org/gnome/terminal/legacy/profiles:/ ; dconf load /org/gnome/terminal/legacy/profiles:/ < ~/dotfiles/gnome_terminal/gnome-terminal.profile
