#! /usr/bin/env bash

if [ $(uname 2>&1) = "Darwin" ]; then
    # macOS
    export MY_ESC_CODE='\033'
else
    # Linux
    export MY_ESC_CODE='\e'
fi

if [ ! -d ~/.config ]; then
    mkdir ~/.config
    echo "~/.config created"
fi

echo "update fish configs symbolic links"
echo "    fish/"; rm -rf ~/.config/fish; ln -s ~/dotfiles/fish/fish ~/.config/fish
