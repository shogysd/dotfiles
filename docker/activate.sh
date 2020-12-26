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

unset bash_url fish_url
bash_url='https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker'
zsh_url='https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/_docker'
fish_url='https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/fish/docker.fish'

echo "download fish completion files"
echo "    for bash" ; rm -f ~/dotfiles/docker/docker.bash ; ${OSDEP_DOWNLOAD_COMMAND} ~/dotfiles/docker/docker.bash ${bash_url}
echo "    for zsh"  ; rm -f ~/dotfiles/docker/docker.zsh  ; ${OSDEP_DOWNLOAD_COMMAND} ~/dotfiles/docker/docker.zsh  ${zsh_url}
echo "    for fish" ; rm -f ~/dotfiles/docker/docker.fish ; ${OSDEP_DOWNLOAD_COMMAND} ~/dotfiles/docker/docker.fish ${fish_url}

mkdir -p ~/dotfiles/posix_shell/zsh/completion
rm -rf ~/dotfiles/posix_shell/zsh/completion/_docker ; ln -s ~/dotfiles/docker/docker.zsh ~/dotfiles/posix_shell/zsh/completion/_docker

unset bash_url fish_url
