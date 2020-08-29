#! /usr/bin/env bash

if [ ! -d ~/.config ]; then
    mkdir ~/.config
    echo "~/.config created"
fi

echo "update fish configs symbolic links"
echo "    fish/"; rm -rf ~/.config/fish; ln -s ~/dotfiles/fish/fish ~/.config/fish
