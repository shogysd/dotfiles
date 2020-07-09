#! env bash
echo "update screen configs symbolic links"
echo "    screenrc" ; rm -f ~/.screenrc ; ln -s ~/config_files/screen_conf/src/screenrc ~/.screenrc
