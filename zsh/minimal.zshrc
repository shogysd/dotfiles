### ------------------ ###
### shell environments ###
### ------------------ ###
export LANG=C


### ---------------- ###
### zsh environments ###
### ---------------- ###
autoload -Uz vcs_info
setopt prompt_subst

# vcsinfoの有効化
zstyle ':vcs_info:git:*' check-for-changes true

# gitの補完
zstyle ':completion:*:*:git:*' option-stacking yes

# staging されているファイルの変更: %c
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}"

# staging されていないファイルの変更: %u
zstyle ':vcs_info:git:*' unstagedstr "%F{red}"

# リポジトリのhashの取得: %i
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:git*' formats "%c%u%r%f | %b | %7.7i"
zstyle ':vcs_info:git*' actionformats '[%b|%a]'

local most_recently_executed_status="%(?,,
%B%F{red}--------------------%f%b)"
local prompt_icon="%(!,#,$)"

LPROMPT='$most_recently_executed_status
%M %~ [ ${vcs_info_msg_0_} ]
$prompt_icon '

PROMPT=${LPROMPT}

# 実行に指定時間 (s) 以上かかったら詳細を表示
REPORTTIME=10

# REPORTTIME のフォーマット
TIMEFMT='

--
$ %J
%U user / %S system / %P cpu / %*E total
--
'

# コマンド実行後に実行
precmd() {
    # コマンド実行直後にvcs情報を更新
    vcs_info
}

# TMOUTごとにTRAPALRMを実行
TMOUT=1
TRAPALRM () {
    # vcs情報を更新
    vcs_info
    # プロンプトを更新
    zle reset-prompt
}

# EOFを受け取ってもシェルを終了しない
setopt IGNOREEOF

# プロンプト表示時に変数を展開
setopt prompt_subst

# 補完
autoload -Uz compinit && compinit

# 単語に含める文字 ( 区切り文字にしない記号 )  デフォルト : '*?_-.[]~=/&;!#$%^(){}<>'
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# プロセス内で保存する履歴の件数
HISTSIZE=99999

# ファイルに保存する履歴の件数
SAVEHIST=99999

# 連続をしたコマンドを1度のみの記録に
setopt hist_ignore_dups

# スペースから始まるコマンドは履歴に追記しない
setopt hist_ignore_space

# 履歴から再実行する際に編集する機会を入れる
setopt hist_verify

# 履歴保存時に余分なスペースを削除する
setopt hist_reduce_blanks

# 履歴を保存するファイル
HISTFILE=~/.zsh_history

# history コマンドは履歴に保存しない
setopt hist_no_store

# プロセス間で履歴を共有する
setopt share_history

# HISTFILEに実行時間も記録する
setopt extended_history

# コマンド補完で大文字と小文字を区別しない
compctl -M 'm:{a-z}={A-Z}'

# cdがなくてもディレクトリの移動を可能にする
setopt auto_cd

# cdのtab補完で過去の移動履歴を参照する
setopt auto_pushd

# ビープを鳴らさない
setopt no_beep
setopt nolistbeep

# typoの修正
setopt correct

# emacsライクにする
bindkey -d
bindkey -e


### ------- ###
### aliases ###
### ------- ###

alias cp='cp -i'
alias dir='dir --color=auto'
alias ema='emacs -nw'
alias emacs='emacs -nw'
alias flush='rm -f *~ .*~ \#*\# \**\*'
alias grep='grep --color=auto'
alias grepn='grep -i --color=auto'
alias history='history -iD 1'
alias hn='hostname'
alias la='ls -A --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias rm='rm -i'
alias sudo='sudo '
alias zz='exit'
alias っz='exit'

# git
alias gd='cd $(git rev-parse --show-toplevel)'

# python
alias py='python3'
alias python-disable_environment_variable='python3 -E'
alias activate='source ./bin/activate'


### -------------- ###
### zsh functiuons ###
### -------------- ###

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    if [[ ${cmd} = (l[sal])
       || ${cmd} = (shis|history)
       || ${cmd} = (hn|hostname)
       || ${cmd} = gd
       || ${cmd} = man
       || ${cmd} = (z|zz|exit)
    ]]; then
        return 1
    else
        return 0
    fi
}


rm -f ~/.zshrc
