#! /bin/sh
echo "update bash configs symbolic links"
echo "    bash_profile" ; rm -f ~/.bash_profile ; ln -s ~/config_files/bash_conf/src/bash_profile ~/.bash_profile
echo "    bashrc"       ; rm -f ~/.bashrc       ; ln -s ~/config_files/bash_conf/src/bashrc       ~/.bashrc
