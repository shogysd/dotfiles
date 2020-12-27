#! /usr/bin/env bash

if [ "$(uname 2>&1)" = "Darwin" ]; then
    # macOS
    export OSDEP_DOWNLOAD_COMMAND='curl -s -o'
else
    # Linux
    export OSDEP_DOWNLOAD_COMMAND='wget -q -O'
fi

echo "update bash configs symbolic links"

rm -f ~/.bash_profile ~/.bashrc
ln -s ~/dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/dotfiles/bash/bashrc       ~/.bashrc


rm -rf ~/.bash/completion
mkdir -p ~/.bash/completion


${OSDEP_DOWNLOAD_COMMAND} ~/.bash/completion/git-completion.bash \
https://raw.githubusercontent.com/git/git/d9f6f3b6195a0ca35642561e530798ad1469bd41/contrib/completion/git-completion.bash

${OSDEP_DOWNLOAD_COMMAND} ~/.bash/completion/docker \
https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker
