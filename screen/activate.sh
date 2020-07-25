#! /usr/bin/env bash
echo "update screen configs symbolic links"
echo "    screenrc" ; rm -f ~/.screenrc ; ln -s ~/dotfiles/screen_conf/src/screenrc ~/.screenrc
