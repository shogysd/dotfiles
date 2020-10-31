#! /usr/bin/env bash

if [ "$(uname 2>&1)" = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

echo "update emacs configs symbolic links"

if [ "$(uname 2>&1)" = "Darwin" ] && [ -x /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
    # macOS
    echo "    make emacs symbokic link" ; rm -f ~/bin/emacs ; ln -s /Applications/Emacs.app/Contents/MacOS/Emacs ~/bin/emacs
fi
echo    "    make .emacs symbolic link" ; rm -f ~/.emacs ; ln -s ~/dotfiles/emacs/emacs ~/.emacs
