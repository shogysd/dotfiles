#! /usr/bin/env bash
echo "update zsh configs symbolic links"
echo "    zprofile" ; rm -f ~/.zprofile ; ln -s ~/dotfiles/zsh/zprofile ~/.zprofile
