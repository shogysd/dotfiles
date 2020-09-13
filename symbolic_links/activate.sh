#! /usr/bin/env bash

if [ $(uname 2>&1) = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

echo "make binfiles symbolic links"

# python path
if [ $(uname 2>&1) = "Darwin" ]; then
    # macOS
    for path in $(find /Library/Frameworks/Python.framework/Versions/* -maxdepth 1 -name bin | sort -r); do
        ${path}/python3 --version | awk -F ' ' '{print $NF}' | grep -e a -e b > /dev/null
        if [ ! $? -eq 0 ]; then
            "python3" ; rm -f ~/python3 ; ln -s $path/python3 ~/python3
            break
        fi
    done
fi
