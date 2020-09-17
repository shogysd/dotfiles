#! /usr/bin/env bash

if [ $(uname 2>&1) = "Darwin" ]; then
    # macOS
    export OSDEP_ESC_CODE='\033'
    export OSDEP_DOWNLOAD_COMMAND='curl -s -o'
else
    # Linux
    export OSDEP_ESC_CODE='\e'
    export OSDEP_DOWNLOAD_COMMAND='wget -q -O'
fi

unset bash_url fish_url
bash_url='https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/fish/docker.fish'
fish_url='https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/fish/docker.fish'

echo "download fish completion files"
echo "    for bash" ; rm -f ~/dotfiles/docker/docker.bash ; ${OSDEP_DOWNLOAD_COMMAND} ~/dotfiles/docker/docker.bash ${bash_url}
echo "    for fish" ; rm -f ~/dotfiles/docker/docker.fish ; ${OSDEP_DOWNLOAD_COMMAND} ~/dotfiles/docker/docker.fish ${fish_url}

unset bash_url fish_url
