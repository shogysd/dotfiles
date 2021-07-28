#! /usr/bin/env bash

if [ "$(uname 2>&1)" = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

mkdir -p ${HOME}/bin
chmod 744 ./*

echo "update scripts configs symbolic links"

for file in $(find . -maxdepth 1 -type f -not -name 'activate.sh'); do
    ln_file=$(echo ${file} | awk -F './' '{print $2}' | awk -F '.' '{print $1}')
    echo    "    make ${ln_file} symbolic link" ; rm -f ~/bin/ln_file ; ln -s ~/dotfiles/scripts/${file} ~/bin/${ln_file}
done
