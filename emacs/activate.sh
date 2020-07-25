#! /usr/bin/env bash
echo "update emacs configs symbolic links"
echo    "    emacs" ; rm -f ~/.emacs ; ln -s ~/dotfiles/emacs/emacs ~/.emacs
