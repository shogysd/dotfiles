#! /usr/bin/env bash

if [ "$(uname 2>&1)" = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

echo "update zsh configs symbolic links"
echo "    zprofile" ; rm -f ~/.zprofile ; ln -s ~/dotfiles/zsh/zprofile ~/.zprofile
echo "    zshrc"    ; rm -f ~/.zshrc    ; ln -s ~/dotfiles/zsh/zshrc    ~/.zshrc

echo "plugin repository clone"
echo "    zsh-autosuggestions"     ; rm -rf ~/.zsh/zsh-autosuggestions     ; git clone https://github.com/zsh-users/zsh-autosuggestions     ~/.zsh/zsh-autosuggestions
echo "    zsh-syntax-highlighting" ; rm -rf ~/.zsh/zsh-syntax-highlighting ; git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
