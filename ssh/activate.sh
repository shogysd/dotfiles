#! env bash
echo "update ssh_conf configs symbolic links"

if [ ! -d "$HOME/.ssh" ]; then
    mkdir ${HOME}/.ssh && echo "$HOME/.ssh was created."
fi

if [ ! -d "$HOME/.ssh/local_conf" ]; then
    mkdir ${HOME}/.ssh/local_conf && echo "$HOME/.ssh/local_conf was created."
fi

cat  ~/config_files/ssh/common                                >  ~/config_files/ssh/config && \
echo ""                                                       >> ~/config_files/ssh/config && \
cat  ~/config_files/ssh/$(echo `uname 2>&1` | tr [A-Z] [a-z]) >> ~/config_files/ssh/config
echo "    conf" ; rm   -f ~/.ssh/config ; cp ~/config_files/ssh/config ~/.ssh/config
