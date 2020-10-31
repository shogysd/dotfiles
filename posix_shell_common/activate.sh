#! /usr/bin/env bash

if [ "$(uname 2>&1)" = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

echo "update bash configs symbolic links"
echo "    bash_profile" ; rm -f ~/.bash_profile ; ln -s ~/dotfiles/bash/bash_profile ~/.bash_profile
echo "    bashrc"       ; rm -f ~/.bashrc       ; ln -s ~/dotfiles/bash/bashrc       ~/.bashrc
