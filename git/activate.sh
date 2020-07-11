#! /bin/bash
echo "update git configs symbolic links"

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
echo ""
echo "update symbolic link"
echo "    gitconfig_envdep_ln" ; rm -f ~/config_files/git/gitconfig_envdep_ln ; ln -s ~/config_files/git/$(echo $(uname 2>&1) | tr [A-Z] [a-z])/gitconfig_envdep ~/config_files/git/gitconfig_envdep_ln
echo "    gitconfig"           ; rm -f ~/.gitconfig                           ; ln -s ~/config_files/git/gitconfig        ~/.gitconfig
echo "    gitignore_global"    ; rm -f ~/.gitignore_global                    ; ln -s ~/config_files/git/gitignore_global ~/.gitignore_global
echo "download git completion" ; rm -f ~/config_files/git/git-completion.bash ; ${MY_DOWNLOAD_COMMAND} ~/config_files/git/git-completion.bash https://raw.githubusercontent.com/git/git/d9f6f3b6195a0ca35642561e530798ad1469bd41/contrib/completion/git-completion.bash
