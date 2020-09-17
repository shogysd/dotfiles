# alias
if [ (uname 2>&1) = "Darwin" ]
    alias ls='ls -G'
    alias md5sum='md5'
    alias ema='emacs'
    alias open='open ./'
else
    alias ema='emacs -nw'
    alias emacs='emacs -nw'
    alias term-profile-export='dconf dump /org/gnome/terminal/legacy/profiles:/ \
                               > ~/dotfiles/Linux/gnome_terminal/gnome-terminal.profile'
    alias term-profile-import='dconf reset -f /org/gnome/terminal/legacy/profiles:/; \
                               dconf load /org/gnome/terminal/legacy/profiles:/ \
                               < ~/dotfiles/Linux/gnome_terminal/gnome-terminal.profile'
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
alias dok='docker'
alias gd='cd (git rev-parse --show-toplevel)'
