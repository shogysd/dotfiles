#! /usr/bin/env bash

if [ ! -d ~/.config ]; then
    mkdir ~/.config
    echo "~/.config created"
fi

echo "update fish configs symbolic links"
echo    "    fish/functions"   ; rm -rf ~/.config/fish/functions   ; ln -s ~/dotfiles/fish/functions       ~/.config/fish/functions
echo    "    fish/imports"     ; rm -rf ~/.config/fish/imports     ; ln -s ~/dotfiles/fish/imports         ~/.config/fish/imports
echo    "    fish/config.fish" ; rm -rf ~/.config/fish/config.fish ; ln -s ~/dotfiles/fish/config.fish     ~/.config/fish/config.fish

# default shell setup
# check: /etc/shells
# $ chsh -s [fish PATH]
