#! /usr/bin/env bash

if [ $(uname 2>&1) = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

if [ ! -d ~/.config ]; then
    mkdir ~/.config
    echo "~/.config created"
fi

echo ""
for i in $(find ~/dotfiles -name activate.sh)
do
    echo "=============================="
    echo ""
    ${i}
    echo ""
done
echo "=============================="
