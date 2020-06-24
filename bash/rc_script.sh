function shell_info(){

    if ( ! `git rev-parse --is-inside-work-tree > /dev/null 2>&1` ); then
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
            echo -ne "${MY_ESC_CODE}[0;39;7mgit:${MY_ESC_CODE}[0;39m "
        fi
    else
        # branch is not clean
        if [ -f ~/.gitignore_global ]; then
            # ~/.gitignore_global is enabled
            echo -ne "${MY_ESC_CODE}[1;31mgit:${MY_ESC_CODE}[0;39m "
        else
            # ~/.gitignore_global is disabled
            echo -ne "${MY_ESC_CODE}[1;31;7mgit:${MY_ESC_CODE}[0;39m "
        fi
    fi
    echo `git rev-parse --show-toplevel | xargs basename`/`git rev-parse --show-prefix`
}


function -gitBranchPrinter(){
    # Precondition: in git tree
    gitBranch=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [ $? = 0 ]; then
        defaultBranch=`git symbolic-ref --short refs/remotes/origin/HEAD 2> /dev/null | xargs basename`
        if [ $? = 0 ]; then
            defaultBranch="master"
        fi
        if [ ${gitBranch} = ${defaultBranch} ]; then
            echo -n "${MY_ESC_CODE}[0;33m${defaultBranch}${MY_ESC_CODE}[0;39m"
        else
            echo -n "${gitBranch}"
        fi
    else
        echo -n "${MY_ESC_CODE}[0;36mdetached${MY_ESC_CODE}[0;39m"
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
        envpath=`echo -n $VIRTUAL_ENV | xargs basename`
        if [ -n "${envpath}" ]; then
            echo -n "[ venv: "${envpath}" ] "
        fi
    fi
}


function -screenStatusPrinter(){
    which screen > /dev/null 2>&1
    if [ $? = "0" ]; then
        # found screen command
        echo -ne "screen ${MY_ESC_CODE}[0;35mattached${MY_ESC_CODE}[0;39m:"
        screen -ls | grep Attached | tr '.' ' ' | awk -F ' ' '{printf " %5s", $1}'
        echo ""
        echo -ne "sereen ${MY_ESC_CODE}[0;36mdetached${MY_ESC_CODE}[0;39m:"
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


function -confModePrinter(){
    echo -ne "${MY_ESC_CODE}[0;32mInformation${MY_ESC_CODE}[0;39m: conf mode is "

    if [ "${MY_CONF_MODE}" = "OWNER" ] || [ "${MY_CONF_MODE}" = "GUEST" ]; then
        echo ${MY_CONF_MODE}
    elif [ "${SSH_CONNECTION}" != "" ] && [ -z ${MY_CONF_MODE} ]; then
        echo "SSH"
    elif [ -z ${MY_CONF_MODE} ] ; then
        echo -e "${MY_ESC_CODE}[1;39mN/A${MY_ESC_CODE}[0;39m"
    else
        echo -ne "${MY_ESC_CODE}[1;31mERROR: ${MY_ESC_CODE}[0;39m"
        echo "MY_ESC_CODE is : ${MY_ESC_CODE}"
    fi
    echo ""
}


function -dir_status(){
    if [ `ls | wc -w` = 0 ]; then
        echo -e "Current directory is clean."
    elif [ ${MY_OS} = "Darwin" ]; then
        ls -G
    else
        # Linux
        ls --color=auto
    fi
}

function -blankLinePrinter(){
    echo ''
}
