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
    echo "    python3"
    rm -f ~/bin/python3 ~/bin/python3.*
    # macOS
    for path in $(find /Library/Frameworks/Python.framework/Versions/* -maxdepth 1 -name bin | sort -r); do
        version=$(echo ${path} | awk -F '/' '{print $(NF - 1)}')
        rm -f ~/bin/python${version}
        ln -s ${path}/python${version} ~/bin/python${version}
    done
    for ln_path in $(find ~/bin -name python3.* | sort -r); do
        ${ln_path} --version | awk -F ' ' '{print $NF}' | grep -e a -e b > /dev/null
        if [ ! $? -eq 0 ]; then
            ln -s ${ln_path} ~/bin/python3
            break
        fi
    done
fi
