#! /usr/bin/env bash

unset start config_file_path add_to_list remove_list

if [ ${EUID:-${UID}} = 0 ]; then
    echo "ERROR"
    exit 1
fi

if [ $(uname 2>&1) = "Darwin" ]; then
    # macOS
    config_file_path="${HOME}/Library/Application Support/Code/User"
else
    # Linux
    config_file_path="${HOME}/.config/Code/User"
fi

echo ""
echo "----- update settings.json, keybindings.json -----"

if [ -d "${config_file_path}" ]; then
    rm -f "${config_file_path}/settings.json"   ; ln -s ~/dotfiles/vscode/settings.json     "${config_file_path}/settings.json"
    rm -f "${config_file_path}/keybindings.json"; ln -s ~/dotfiles/vscode/keybindings.json  "${config_file_path}/keybindings.json"
    echo "complete !!"
else
    echo -e "${MY_ESC_CODE}[1;39mconfig dir ( ${config_file_path} ) not found!! ${MY_ESC_CODE}[0;39m"
fi

echo ""
echo -ne "${MY_ESC_CODE}[1;39mstart update vscode plugins?: ${MY_ESC_CODE}[0;39m"
echo -ne "${MY_ESC_CODE}[1;35myes${MY_ESC_CODE}[0;39m-or-other ( NOT 'y' ): "
read start
if [ -z ${start} ] || [ $start != "yes" ]; then
    :
elif ! $(which code); then
    echo "error: (code) command not found"
else
    echo ""
    echo "----------------- update plugins -----------------"
    cp ~/dotfiles/vscode/plugin_list.txt ~/dotfiles/vscode/plugin_list_tmp.txt && \
        code --list-extensions >> ~/dotfiles/vscode/plugin_list_tmp.txt && \
        cat ~/dotfiles/vscode/plugin_list_tmp.txt | sort | uniq > ~/dotfiles/vscode/plugin_list_currend_merged.txt && \
        rm -f ~/dotfiles/vscode/plugin_list_tmp.txt

    for i in $(cat ~/dotfiles/vscode/plugin_list_currend_merged.txt)
    do
        cat ~/dotfiles/vscode/plugin_list.txt | grep -q ${i}
        if [ $? != 0 ]; then
            echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
            echo -n "current only plugin : "
            echo -e "${MY_ESC_CODE}[1;39m${i}${MY_ESC_CODE}[0;39m"
            echo -n "    add to plugin_list?: y-or-other: "
            read add_to_list
            if [ -z ${add_to_list} ] || [ ${add_to_list} != "y" ]; then
                echo -n "    remove plugin?: y-or-other: "
                read remove_plugin
                if [ ${remove_plugin} = "y" ]; then
                    code --uninstall-extension ${i}
                fi
            else
                echo ${i} >> ~/dotfiles/vscode/plugin_add_tmp_list.txt
            fi
            echo "-----"
        fi
    done

    rm -f ~/dotfiles/vscode/plugin_list_currend_merged.txt

    if [ -f ~/dotfiles/vscode/plugin_add_tmp_list.txt ]; then
        echo ""
        cat ~/dotfiles/vscode/plugin_add_tmp_list.txt >> ~/dotfiles/vscode/plugin_list.txt
        rm ~/dotfiles/vscode/plugin_add_tmp_list.txt
        cat ~/dotfiles/vscode/plugin_list.txt | sort | uniq > ~/dotfiles/vscode/plugin_list_tmp.txt
        rm ~/dotfiles/vscode/plugin_list.txt
        mv ~/dotfiles/vscode/plugin_list_tmp.txt ~/dotfiles/vscode/plugin_list.txt
    fi

    cp ~/dotfiles/vscode/plugin_list.txt ~/dotfiles/vscode/plugin_list_.txt
    for i in $(cat ~/dotfiles/vscode/plugin_list_.txt)
    do
        echo ${i}
        code --install-extension ${i} > /dev/null 2>&1
        if [ 1 = ${?} ]; then
            echo "--"
            echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
            echo "command exec error: \$code --install-extension ${i}"
            echo -ne "${MY_ESC_CODE}[1;39mremove ${i} in plugin_list.txt?${MY_ESC_CODE}[0;39m"
            echo -n " : y-or-other: "
            read remove_list
            if [ -z ${remove_list} ] || [ ${remove_list} != "y" ]; then
                :
            else
                cat ~/dotfiles/vscode/plugin_list.txt | grep -v "${i}" > ~/dotfiles/vscode/plugin_list_tmp.txt
                rm ~/dotfiles/vscode/plugin_list.txt
                mv ~/dotfiles/vscode/plugin_list_tmp.txt ~/dotfiles/vscode/plugin_list.txt
                # sed -i "" "/${i}/d" ~/dotfiles/vscode/plugin_list.txt
            fi
            echo "--"
        fi
    done

    rm ~/dotfiles/vscode/plugin_list_.txt

fi
unset start config_file_path add_to_list remove_list
echo ""
echo "vscode config updated!!"
