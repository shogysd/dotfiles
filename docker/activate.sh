#! /usr/bin/env bash

if [ "$(uname 2>&1)" = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
    export OSDEP_DOWNLOAD_COMMAND='curl -s -o'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
    export OSDEP_DOWNLOAD_COMMAND='wget -q -O'
fi

rm -f ~/.bash/completion/docker ~/.zsh/completion/_docker
mkdir -p ~/.bash/completion ~/.zsh/completion

${OSDEP_DOWNLOAD_COMMAND} ~/.bash/completion/docker \
https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker

${OSDEP_DOWNLOAD_COMMAND} ~/.zsh/completion/_docker \
https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/_docker
