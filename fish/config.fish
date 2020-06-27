set -x MY_OS (uname 2>&1)

# env
if [ $MY_OS = "Darwin" ]
    # macOS
    export MY_ESC_CODE='\033'
    export MY_DOWNLOAD_COMMAND='curl -s -o'
    # export BASH_SILENCE_DEPRECATION_WARNING=1
else
    # Linux
    export MY_ESC_CODE='\e'
    export MY_DOWNLOAD_COMMAND='wget -q -O'
end

set -x fish_user_paths $HOME/.bin
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -x VISUAL ':'
set -x EDITOR 'emacs'


# alias
if [ $MY_OS = "Darwin" ]
    alias ls='ls -G'
    alias md5sum='md5'
    alias ema='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
    alias open='open ./'
else
    alias ema='emacs -nw'
    alias term-profile-export='dconf dump /org/gnome/terminal/legacy/profiles:/ \
                               > ~/config_files/Linux/gnome_terminal/gnome-terminal.profile'
    alias term-profile-import='dconf reset -f /org/gnome/terminal/legacy/profiles:/; \
                               dconf load /org/gnome/terminal/legacy/profiles:/ \
                               < ~/config_files/Linux/gnome_terminal/gnome-terminal.profile'
    alias open='nautilus ./'
end
alias sudo='sudo '
alias grep='grep --color=auto'
alias grepn='grep -i --color=auto'
alias rm='rm -i'
alias rm-y='\rm'
alias dir='dir --color=auto'
alias hn='hostname'
alias flush='rm -f *~ .*~ \#*\# \**\*'
alias cp='cp -i'
alias pd-clear='dirs -c'
alias py='python3'
alias gd='cd (git rev-parse --show-toplevel)'

# PATH
if [ $MY_OS = "Darwin" ] && [ ! (echo $PATH | grep "/Library/Frameworks/Python.framework/Versions/") ]
    # macOS
    set -x PATH (find /Library/Frameworks/Python.framework/Versions/* -maxdepth 1 -name bin | sort -r | head -n 1) $PATH
# else
    # Linux
end
