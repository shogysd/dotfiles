#! /bin/sh
echo "update emacs configs symbolic links"
echo    "    emacs" ; rm -f ~/.emacs ; ln -s ~/config_files/emacs/emacs ~/.emacs
