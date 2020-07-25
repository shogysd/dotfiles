#! /usr/bin/env bash
echo "update bash configs symbolic links"
echo "    bash_profile" ; rm -f ~/.bash_profile ; ln -s ~/dotfiles/bash/bash_profile ~/.bash_profile
echo "    bashrc"       ; rm -f ~/.bashrc       ; ln -s ~/dotfiles/bash/bashrc       ~/.bashrc
