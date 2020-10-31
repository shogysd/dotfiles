#! /usr/bin/env bash

if [ "$(uname 2>&1)" = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

echo "update zsh configs symbolic links"
echo "    zprofile" ; rm -f ~/.zprofile ; ln -s ~/dotfiles/posix_shell/zsh/zprofile ~/.zprofile
echo "    zshrc"    ; rm -f ~/.zshrc    ; ln -s ~/dotfiles/posix_shell/zsh/zshrc    ~/.zshrc
