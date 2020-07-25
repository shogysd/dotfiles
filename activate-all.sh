#! /usr/bin/env bash

for i in $(find ~/dotfiles -name activate.sh)
do
    ${i}
done

