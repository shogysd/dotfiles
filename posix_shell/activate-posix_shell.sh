#! /usr/bin/env bash

if [ "$(uname 2>&1)" = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
fi

echo ""
for i in $(ls -f ~/dotfiles/posix_shell/*/activate.sh)
do
    echo "=============================="
    echo ""
    ${i}
    echo ""
done
echo "=============================="
