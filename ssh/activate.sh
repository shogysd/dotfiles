#! /usr/bin/env bash
echo "update ssh_conf configs symbolic links"

if [ ! -d "$HOME/.ssh" ]; then
    mkdir ${HOME}/.ssh && echo "$HOME/.ssh was created."
fi

if [ ! -d "$HOME/.ssh/local_conf" ]; then
    mkdir ${HOME}/.ssh/local_conf && echo "$HOME/.ssh/local_conf was created."
fi

cat  ~/dotfiles/ssh/common                                >  ~/dotfiles/ssh/config && \
echo ""                                                       >> ~/dotfiles/ssh/config && \
cat  ~/dotfiles/ssh/$(echo `uname 2>&1` | tr [A-Z] [a-z]) >> ~/dotfiles/ssh/config
echo "    conf" ; rm   -f ~/.ssh/config ; cp ~/dotfiles/ssh/config ~/.ssh/config
