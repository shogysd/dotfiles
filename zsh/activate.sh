#! /usr/bin/env bash

if [ $(uname 2>&1) = "Darwin" ]; then
    # macOS
    export MY_ESC_CODE='\033'
else
    # Linux
    export MY_ESC_CODE='\e'
fi

echo "update zsh configs symbolic links"
echo "    zprofile" ; rm -f ~/.zprofile ; ln -s ~/dotfiles/zsh/zprofile ~/.zprofile
