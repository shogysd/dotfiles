#!/bin/bash

if [ ${EUID:-${UID}} = 0 ]; then
    echo "ERROR"
    exit 1
fi

if [ "$(uname 2>&1)" = "" ]; then
    MY_OS=`uname 2>&1`
fi

echo ""
echo -ne "${MY_ESC_CODE}[1;39mstart update ~/.gitconfig?: ${MY_ESC_CODE}[0;39m"
echo -n "y-or-other: "
read start
if [ -z ${start} ] || [ "${start}" != "y" ]; then
    echo "~/.gitconfig update passed!!"
else
    echo -ne "${MY_ESC_CODE}[1;39mflush old gitconfig ( $ rm -f ~/.gitconfig ) ?: ${MY_ESC_CODE}[0;39m"
    echo -n "y-or-other: "
    read flushgitconfig
    if [ -z ${flushgitconfig} ] || [ ${flushgitconfig} != "y" ]; then
        :
    else
        user_name=$(git config --global user.name)
        user_email=$(git config --global user.email)
        rm -f ~/.gitconfig > /dev/null 2>&1
        if [ ! -z "${user_name}" ]; then
            git config --global user.name "${user_name}"
        fi
        if [ ! -z "${user_email}" ]; then
            git config --global user.email "${user_email}"
        fi
    fi

    if [ $(uname 2>&1) = "Darwin" ]; then
        git config --global core.editor '/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
    else
        git config --global core.editor 'emacs -nw'
    fi

    git config --global core.excludesfile ~/.gitignore_global
    git config --global core.pager less

    git config --global color.ui true
    git config --global core.autocrlf input

    # git config --global push.default nothing
    git config --global push.default simple

    git config --global fetch.prune 'true'

    git config --global alias.br          'branch -v'
    git config --global alias.cl          'clone'
    git config --global alias.cla         'clone --recursive'
    git config --global alias.co          'checkout'
    git config --global alias.comm        '!git rev-parse --is-inside-work-tree > /dev/null && cd $(git rev-parse --show-toplevel) && git commit'
    git config --global alias.df          'diff'
    git config --global alias.di          'diff'
    git config --global alias.diffname    'diff --name-only'
    git config --global alias.diffword    'diff --word-diff'
    git config --global alias.din         'diff --name-only'
    git config --global alias.diw         'diff --word-diff'
    git config --global alias.gr          'grep -n'
    git config --global alias.grepn       'grep -n'
    git config --global alias.hash        'rev-parse --short HEAD'
    git config --global alias.st          'status'
    git config --global alias.sub         'submodule update --init --recursive'

    if [ $(uname 2>&1) = "Darwin" ]; then
        # macOS
        git config --global alias.ad '!git rev-parse --is-inside-work-tree > /dev/null && cd $(git rev-parse --show-toplevel) && xattr -cr && find . -name .DS_Store | xargs rm -rf && git add .'
    else
        # Linux
        git config --global alias.ad '!git rev-parse --is-inside-work-tree > /dev/null && cd $(git rev-parse --show-toplevel) && git add .'
    fi

    echo ""
    echo "~/.gitconfig updated!!"

fi

echo ""
echo "conf file: ~/.gitconfig"
echo ""
echo "-----"
echo "git current user info..."
# print user name
echo -n "    user.name  : "
user_name=$(git config --global user.name)
if [ -z "${user_name}" ]; then
    echo -e "${MY_ESC_CODE}[1;35muser name not found${MY_ESC_CODE}[0;39m"
else
    echo ${user_name}
fi
# print user email
echo -n "    user.email : "
user_email=$(git config --global user.email)
if [ -z "${user_email}" ]; then
    echo -e "${MY_ESC_CODE}[1;35muser email not found${MY_ESC_CODE}[0;39m"
else
    echo ${user_email}
fi
echo "-----"
# echo "change or update"
# echo "$ git config --global user.name '[username]'"
# echo "$ git config --global user.email '[useremail]'"
# echo ""
