#! /usr/bin/env bash
echo "update fish configs symbolic links"
echo    "    fish/functions"   ; rm -rf ~/.config/fish/functions   ; ln -s ~/config_files/fish/functions       ~/.config/fish/functions
echo    "    fish/imports"     ; rm -rf ~/.config/fish/imports     ; ln -s ~/config_files/fish/imports         ~/.config/fish/imports
echo    "    fish/config.fish" ; rm -rf ~/.config/fish/config.fish ; ln -s ~/config_files/fish/config.fish     ~/.config/fish/config.fish
