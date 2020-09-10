#! /usr/bin/env bash

if [ $(uname 2>&1) = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

echo "update screen configs symbolic links"
echo "    screenrc" ; rm -f ~/.screenrc ; ln -s ~/dotfiles/screen_conf/src/screenrc ~/.screenrc
