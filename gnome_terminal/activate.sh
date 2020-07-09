#! /usr/bin/env bash
echo "update gnome-terminal configs"
dconf reset -f /org/gnome/terminal/legacy/profiles:/ ; dconf load /org/gnome/terminal/legacy/profiles:/ < ~/config_files/gnome_terminal/gnome-terminal.profile
