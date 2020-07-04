function config-update(){

    unset tmp_cd start remote_github_account conf_mode conf_mode_read

    ### run mode print
    echo ""
    echo "auto setup script for config file updater"
    echo -ne "${MY_ESC_CODE}[1;32mInformation: ${MY_ESC_CODE}[0;39m"
    echo -n "conf mode is "
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

    if [ $# -gt 1 ]; then
        echo -ne "${MY_ESC_CODE}[1;31mERROR: ${MY_ESC_CODE}[0;39m"
        echo "arg error"
        return 1
    fi

    ### env check
    if [ -z ${MY_REMOTE_GITHUB_ACCOUNT} ]; then
        echo     ""
        echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
        echo     "env-variable: MY_REMOTE_GITHUB_ACCOUNT not found"
        echo -ne "${MY_ESC_CODE}[1;39minput remote github account: ${MY_ESC_CODE}[0;39m"
        read remote_github_account
    else
        remote_github_account=${MY_REMOTE_GITHUB_ACCOUNT}
    fi

    if [ -z ${MY_CONF_MODE} ]; then
        echo     ""
        echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
        echo     "env-variable: MY_CONF_MODE not found"
        echo -ne "${MY_ESC_CODE}[1;39minput conf mode ${MY_ESC_CODE}[0;39m"
        echo -n  " ( OWNER(o)-or-GUEST(g) ): "
        read conf_mode_read
        conf_mode=$(echo ${conf_mode_read} | tr [A-Z] [a-z])
        unset conf_mode_read
        if [ "${conf_mode}" != "owner" ] && [ "${conf_mode}" != "o" ] && [ "${conf_mode}" != "guest" ] && [ "${conf_mode}" != "g" ]; then
            echo -ne "${MY_ESC_CODE}[1;31mERROR: ${MY_ESC_CODE}[0;39m"
            echo "read conf_mode: error: ${conf_mode}"
            return 1
        else
            if [ "${conf_mode}" = "owner" ] || [ "${conf_mode}" = "o" ]; then
                conf_mode="OWNER"
            else
                conf_mode="GUEST"
            fi
        fi
    else
        conf_mode=${MY_CONF_MODE}
    fi

    if [ "${conf_mode}" != "OWNER" ] && [ "${conf_mode}" != "GUEST" ]; then
        echo -ne "${MY_ESC_CODE}[1;31mERROR: ${MY_ESC_CODE}[0;39m"
        echo "env-variable: MY_CONF_MODE error"
        return 1
    fi
    ### env check finish

    ### config update start
    echo     ""
    echo -e  "${MY_ESC_CODE}[1;39mrun info${MY_ESC_CODE}[0;39m"
    echo     "  remote github account : ${remote_github_account}"
    echo     "  exec conf mode        : ${conf_mode}"
    echo -ne "${MY_ESC_CODE}[1;39mstart setup?: ${MY_ESC_CODE}[0;39m"
    echo -n  "y-or-other: "
    read start
    echo ""

    if [ -z ${start} ] || [ "${start}" != "y" ]; then
        return 1
    fi

    if [ "$( pwd | grep ${home}/config_files )" ]; then
        tmp_cd="True"
        pushd ~ > /dev/null
    fi


    if [ "${MY_CONF_MODE}" = "OWNER" ]; then

        ### OWNER mode valid start
        if [ -d ~/config_files/ ] && [ -n "$(git -C ~/config_files/ status --porcelain)" ]; then
            echo ""
            echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
            echo "repository ( ~/config_files ) is not clean"
            echo -ne "${MY_ESC_CODE}[1;39mcontinue READY?: ${MY_ESC_CODE}[0;39m"
            echo -n "y-or-other: "
            read start
            echo ""
            if [ -z ${start} ] || [ "${start}" != "y" ]; then
                return 1
            fi
        fi

        if [ -d ~/config_files/ ] && [ -n "$(git diff origin/master 2> /dev/null)" ]; then
            echo ""
            echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
            echo "current repository ( ~/config_files ) and remote master hashes do not match"
            echo -ne "${MY_ESC_CODE}[1;39mcontinue READY?: ${MY_ESC_CODE}[0;39m"
            echo -n "y-or-other: "
            read start
            echo ""
            if [ -z ${start} ] || [ "${start}" != "y" ]; then
                return 1
            fi
        fi

        if [ -d ~/config_files/ ] && [ ! "master" = "$(git -C ~/config_files/ symbolic-ref --short HEAD 2> /dev/null)" ] && ( ! `git rev-parse --is-inside-work-tree > /dev/null 2>&1` ); then
            echo ""
            echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
            echo "branch ( ~/config_files : $(git -C ~/config_files/ symbolic-ref --short HEAD 2> /dev/null) ) is not master"
            echo -ne "${MY_ESC_CODE}[1;39mcontinue READY?: ${MY_ESC_CODE}[0;39m"
            echo -n "y-or-other: "
            read start
            echo ""
            if [ -z ${start} ] || [ "${start}" != "y" ]; then
                return 1
            fi
        fi
        if [ $# = 1 ] && [ ${1:0:1} = "-" ]; then
            git -C ~/config_files checkout -b ${1} origin/${1}
            if [ $? != 0 ]; then
                echo -ne "${MY_ESC_CODE}[1;31mERROR: ${MY_ESC_CODE}[0;39m"
                echo "branch select ( ${1} ) will be skip"
                read
            fi
        fi
        ### OWNER mode valid finish

        mv ~/config_files ~/config_files_BAK && \
            git -C ~/ clone git@github.com:${remote_github_account}/config_files.git

    elif [ "${MY_CONF_MODE}" = "GUEST" ]; then
        if [ $# = 1 ]; then
            echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
            echo "change branch is not support in GUEST mode"
        fi
        mv ~/config_files ~/config_files_BAK && \
            ${MY_DOWNLOAD_COMMAND} ~/config_files-master.zip https://codeload.github.com/${remote_github_account}/config_files/zip/master && \
            unzip ~/config_files-master.zip && \
            rm -f ~/config_files-master.zip && \
            mv ~/config_files-master ~/config_files
    fi
    ### source download finish


    ### error printer
    if [ $? != 0 ]; then
        # git clone or download error
        rm -rf ~/config_files
        mv ~/config_files_BAK ~/config_files
        echo ""
        echo -ne "${MY_ESC_CODE}[1;31mERROR: ${MY_ESC_CODE}[0;39m"
        echo "config_files backup error or clone ( or download ) error!!"
        return 1
    fi
    rm -rf ~/config_files_BAK


    ### change branch
    if [ "${MY_CONF_MODE}" = "OWNER" ] && [ $# = 1 ]; then
        git -C ~/config_files checkout -b ${1} origin/${1}
        if [ $? != 0 ]; then
            echo ""
            echo -ne "${MY_ESC_CODE}[1;31mERROR: ${MY_ESC_CODE}[0;39m"
            echo "cannot checkout to origin/${1} ( $ git checkout -b ${1} origin/${1} )"
            echo -n "use default branch: press enter: "
            echo ""
            read
        fi
    fi


    ### generate ssh/config
    cat  ~/config_files/ssh/common                            >  ~/config_files/ssh/config && \
    echo ""                                                   >> ~/config_files/ssh/config && \
    cat  ~/config_files/ssh/$(echo ${MY_OS} | tr [A-Z] [a-z]) >> ~/config_files/ssh/config

    ### update ~/.gitconfig_userinfo
    unset git_user_name git_user_email
    git_user_name=$(git config user.name)
    git_user_email=$(git config user.email)
    reset_flag="False"
    echo ""
    if [ ! -f ~/.gitconfig_userinfo ] || [ -z "${git_user_name}" ] || [ -z "${git_user_email}" ]; then
        echo -e "${MY_ESC_CODE}[1;39msetup git user global info${MY_ESC_CODE}[0;39m"
        reset_flag="True"
    else
        echo -e  "${MY_ESC_CODE}[1;39mgit global user info${MY_ESC_CODE}[0;39m"
        echo     "  - user.name  : ${git_user_name}"
        echo     "  - user.email : ${git_user_email}"
        echo -n  "update git user info?: y-or-other: "
        read update
        if [ ! -z ${update} ] && [ "${update}" = "y" ]; then
            reset_flag="True"
        fi
        unset update
    fi
    if [ "${reset_flag}" = "True" ]; then
        echo -n "    git user.name  : "
        read git_user_name_read
        echo -n "    git user.email : "
        read git_user_email_read
        if [ ! -z "${git_user_name_read}" ] && [ ! -z "${git_user_email_read}" ]; then
            git_user_name=${git_user_name_read}
            git_user_email=${git_user_email_read}
        else
            echo -e "${MY_ESC_CODE}[1;39mupdate skip${MY_ESC_CODE}[0;39m ( entered string is blank )"
        fi
    fi
    rm -f ~/.gitconfig ~/.gitconfig_userinfo
    git   config --global user.name  "${git_user_name}"
    git   config --global user.email "${git_user_email}"
    mv    ~/.gitconfig ~/.gitconfig_userinfo
    unset git_user_name git_user_email git_user_name_read git_user_email_read update reset_flag


    ### make symbolic link (config file)
    ln -s ~/config_files/git/$(echo ${MY_OS} | tr [A-Z] [a-z])/gitconfig_envdep ~/config_files/git/gitconfig_envdep_ln
    echo    ""
    echo -e "${MY_ESC_CODE}[1;39mupdate symbolic link${MY_ESC_CODE}[0;39m"
    echo    "    bash_profile"      ; rm -f ~/.bash_profile             ; ln -s ~/config_files/bash/bash_profile    ~/.bash_profile
    echo    "    bashrc"            ; rm -f ~/.bashrc                   ; ln -s ~/config_files/bash/bashrc          ~/.bashrc
    echo    "    screenrc"          ; rm -f ~/.screenrc                 ; ln -s ~/config_files/screen/screenrc      ~/.screenrc
    echo    "    emacs"             ; rm -f ~/.emacs                    ; ln -s ~/config_files/emacs/emacs          ~/.emacs
    echo    "    gitconfig"                                             ; ln -s ~/config_files/git/gitconfig        ~/.gitconfig
    echo    "    gitignore_global"  ; rm -f ~/.gitignore_global         ; ln -s ~/config_files/git/gitignore_global ~/.gitignore_global
    echo    "    fish/functions"    ; rm -rf ~/.config/fish/functions   ; ln -s ~/config_files/fish/functions       ~/.config/fish/functions
    echo    "    fish/functions"    ; rm -rf ~/.config/fish/imports     ; ln -s ~/config_files/fish/imports         ~/.config/fish/imports
    echo    "    fish/functions"    ; rm -rf ~/.config/fish/config.fish ; ln -s ~/config_files/fish/config.fish     ~/.config/fish/config.fish


    ### make symbolic link (bin file)
    # not content

    ### generate file
    echo    ""
    echo -e "${MY_ESC_CODE}[1;39mfile update${MY_ESC_CODE}[0;39m"
    echo    "    ssh/config"
    rm   -f ~/.ssh/config; cp ~/config_files/ssh/config ~/.ssh/config
    echo    "    git-completion.bash"
    rm   -f ~/config_files/git/git-completion.bash
    ${MY_DOWNLOAD_COMMAND} ~/config_files/git/git-completion.bash https://raw.githubusercontent.com/git/git/d9f6f3b6195a0ca35642561e530798ad1469bd41/contrib/completion/git-completion.bash


    if [ ${MY_OS} = "Linux" ]; then
        # Linux
        dconf reset -f /org/gnome/terminal/legacy/profiles:/; \
            dconf load /org/gnome/terminal/legacy/profiles:/ < ~/config_files/Linux/gnome_terminal/gnome-terminal.profile
    fi

    ### vs-code
    which code > /dev/null 2>&1
    if [ $? = "0" ]; then
        ~/config_files/vscode/vscode_configscript.sh
    else
        echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
        echo "'code' command not found"
    fi

    ### print git userinfo
    echo ""
    echo "-----"
    if [ "$(git config user.name)" = "$(cat ~/.gitconfig_userinfo | grep name | awk -F ' = ' '{print $2}')" ] && \
    [ "$(git config user.email)" = "$(cat ~/.gitconfig_userinfo | grep email | awk -F ' = ' '{print $2}')" ]; then
        echo "git global user info"
        echo "    user.name  : $(git config user.name)"
        echo "    user.email : $(git config user.email)"
    else
        echo -ne "${MY_ESC_CODE}[1;31mERROR: ${MY_ESC_CODE}[0;39m"
        echo "git load user info does NOT match ~/.gitconfig_userinfo"
    fi
    echo "-----"

    ###
    ### zip pack
    ###
    echo ""
    echo "----------------------------------------"
    echo -n "packing ssh_config_files.zip ... "
    mkdir ~/config_files/ssh_config_files/config_files/
    cp -r ~/config_files/bash                               ~/config_files/ssh_config_files/config_files/
    echo -e "\ntrap \"ls -la ~ | grep '^l' | grep ~/config_files | awk -F '->' '{print $1}' | awk -F ' ' '{print $NF}' | xargs rm -f; rm -rf ~/config_files ~/ssh_config_files.zip\" SIGHUP\n" >> ~/config_files/ssh_config_files/config_files/bash/bashrc
    cp -r ~/config_files/emacs                              ~/config_files/ssh_config_files/config_files/
    mkdir ~/config_files/ssh_config_files/config_files/git/
    cp -r ~/config_files/git/gitignore_global               ~/config_files/ssh_config_files/config_files/git/
    cp -r ~/config_files/git/git-completion.bash            ~/config_files/ssh_config_files/config_files/git/
    cp    ~/config_files/git/gitconfig                      ~/config_files/ssh_config_files/config_files/git/gitconfig
    cp    ~/config_files/git/linux/gitconfig_envdep         ~/config_files/ssh_config_files/config_files/git/gitconfig_envdep_ln
    cp -r ~/config_files/screen                             ~/config_files/ssh_config_files/config_files/
    cp    ~/config_files/ssh_config_files/bash_logout       ~/config_files/ssh_config_files/config_files/bash/
    cp    ~/config_files/ssh_config_files/setup.sh          ~/config_files/ssh_config_files/config_files/
    pushd ~/config_files/ssh_config_files/ > /dev/null
    zip -qr ssh_config_files.zip config_files
    popd > /dev/null
    rm -rf ~/config_files/ssh_config_files/config_files
    echo "complete!!"
    echo "----------------------------------------"

    if [ "${tmp_cd}" = "True" ]; then
        popd > /dev/null
    fi

    unset tmp_cd start remote_github_account conf_mode conf_mode_read
    source ~/.bash_profile
}
