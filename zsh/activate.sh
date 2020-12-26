#! /usr/bin/env bash

if [ "$(uname 2>&1)" = "Darwin" ]; then
    # macOS
    export OSDEP_DOWNLOAD_COMMAND='curl -s -o'
else
    # Linux
    export OSDEP_DOWNLOAD_COMMAND='wget -q -O'
fi

echo "update zsh configs symbolic links"

rm -f ~/.zprofile ~/.zshrc
ln -s ~/dotfiles/zsh/zprofile ~/.zprofile
ln -s ~/dotfiles/zsh/zshrc    ~/.zshrc


rm -rf ~/.zsh/zsh-autosuggestions ~/.zsh/zsh-syntax-highlighting ~/.zsh/completion
mkdir -p ~/.zsh/completion

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting

${OSDEP_DOWNLOAD_COMMAND} ~/.zsh/completion/git-completion.zsh \
https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

${OSDEP_DOWNLOAD_COMMAND} ~/.zsh/completion/docker.zsh \
https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/_docker
