function shell_info(){
    if ( ! $(git rev-parse --is-inside-work-tree > /dev/null 2>&1) ); then
        echo -e "${BASICINFO}  ( $(-pathWriter) )"
    else
        echo -e "${BASICINFO}  ( $(-gitRepoPathWriter) ) < $(-gitBranchPrinter) | $(-gitHashPrinter) >"
    fi
}


function -pathWriter(){
    if [ "$( pwd | grep ${HOME} )" ]; then
        pwd | sed "s\`${HOME}\`~\`g"
    else
        pwd
    fi
}


function -gitRepoPathWriter(){
    # Precondition: in git tree
    if [ -z "$(git status --porcelain)" ]; then
        # branch is clean
        if [ -f ~/.gitignore_global ]; then
            # ~/.gitignore_global is enabled
            echo -n "git: "
        else
            # ~/.gitignore_global is disabled
            echo -ne "${OSDEP_ESC_CODE}[0;39;7mgit:${OSDEP_ESC_CODE}[0;39m "
        fi
    else
        # branch is not clean
        if [ -f ~/.gitignore_global ]; then
            # ~/.gitignore_global is enabled
            echo -ne "${OSDEP_ESC_CODE}[1;31mgit:${OSDEP_ESC_CODE}[0;39m "
        else
            # ~/.gitignore_global is disabled
            echo -ne "${OSDEP_ESC_CODE}[1;31;7mgit:${OSDEP_ESC_CODE}[0;39m "
        fi
    fi
    # echo $(git rev-parse --show-toplevel | xargs basename)/$(git rev-parse --show-prefix)
    echo $(git rev-parse --show-toplevel | awk -F '/' '{print $NF}')/$(git rev-parse --show-prefix)
}


function -gitBranchPrinter(){
    # Precondition: in git tree
    gitBranch=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [ $? = 0 ]; then
        # defaultBranch=$(git symbolic-ref --short refs/remotes/origin/HEAD 2> /dev/null | xargs basename)
        defaultBranch=$(git symbolic-ref --short refs/remotes/origin/HEAD 2> /dev/null | awk -F '/' '{print $NF}')
        if [ $? = 0 ]; then
            defaultBranch="master"
        fi
        if [ ${gitBranch} = ${defaultBranch} ]; then
            echo -n "${OSDEP_ESC_CODE}[0;33m${defaultBranch}${OSDEP_ESC_CODE}[0;39m"
        else
            echo -n "${gitBranch}"
        fi
    else
        echo -n "${OSDEP_ESC_CODE}[0;36mdetached${OSDEP_ESC_CODE}[0;39m"
    fi
}


function -gitHashPrinter(){
    # Precondition: in git tree
    gitHash=$(git rev-parse --short HEAD 2> /dev/null)
    if [ $? = 0 ]; then
        echo -n "${gitHash}"
    else
        echo -n "Not committed"
    fi
}


function -envWriter(){
    if [ ! -z "$VIRTUAL_ENV" ]; then
        echo -n "[ venv: "`echo -n $VIRTUAL_ENV | xargs basename`" ] "
    fi
}


function -screenStatusPrinter(){
    which screen > /dev/null 2>&1
    if [ $? = "0" ]; then
        # found screen command
        echo -ne "screen ${OSDEP_ESC_CODE}[0;35mattached${OSDEP_ESC_CODE}[0;39m:"
        screen -ls | grep Attached | tr '.' ' ' | awk -F ' ' '{printf " %5s", $1}'
        echo ""
        echo -ne "sereen ${OSDEP_ESC_CODE}[0;36mdetached${OSDEP_ESC_CODE}[0;39m:"
        screen -ls | grep Detached | tr '.' ' ' | awk -F ' ' '{printf " %5s", $1}'
        echo -e "\n"
    fi
}

function -sshScreenStarter(){
    which screen > /dev/null 2>&1
    # シェルの深さが1でSSHされている場合に起動
    if [ $SHLVL = 1 ] && [ "$TERM" != 'dumb' ] && [ "${SSH_CONNECTION}" != "" ] && [ $? = "0" ] && [ -f ~/.screenrc ]; then
        $(which screen)
    fi
}


function -bashIconWriter(){
    if [ "${SHELL_NAME}" = "bash" ]; then
        echo -n 'bash '
    elif [ "${SHELL_NAME}" = "zsh" ]; then
        echo -n 'zsh '
    else
        echo "SHELL_NAME is '${SHELL_NAME}'"
    fi
}


function -dir_status(){
    if [ `ls | wc -w` = 0 ]; then
        echo -e "Current directory is clean."
    elif [ "$(uname 2>&1)" = "Darwin" ]; then
        ls -G
    else
        # Linux
        ls --color=auto
    fi
}

function -blankLinePrinter(){
    echo ''
}
