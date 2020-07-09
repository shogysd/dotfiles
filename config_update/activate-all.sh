#! /usr/bin/env bash

for i in $(find ~/config_files -name activate.sh)
do
    ${i}
done

