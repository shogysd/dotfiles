#! /usr/bin/env bash

if [ ! -d ~/.config ]; then
    mkdir ~/.config
    echo "~/.config created"
fi

for i in $(find ~/dotfiles -name activate.sh)
do
    ${i}
done

