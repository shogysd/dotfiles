rm -f ~/.bash_profile     ; ln -s ~/config_files/bash/bash_profile    ~/.bash_profile
rm -f ~/.bashrc           ; ln -s ~/config_files/bash/bashrc          ~/.bashrc
rm -f ~/.bash_logout      ; ln -s ~/config_files/bash/bash_logout     ~/.bash_logout
rm -f ~/.screenrc         ; ln -s ~/config_files/screen/screenrc      ~/.screenrc
rm -f ~/.emacs            ; ln -s ~/config_files/emacs/emacs          ~/.emacs
rm -f ~/.gitignore_global ; ln -s ~/config_files/git/gitignore_global ~/.gitignore_global

trap "ls -la ~ | grep '^l' | grep ~/config_files | awk -F '->' '{print $1}' | awk -F ' ' '{print $NF}' | xargs rm -f; rm -rf ~/config_files ~/ssh_config_files.zip" SIGHUP
