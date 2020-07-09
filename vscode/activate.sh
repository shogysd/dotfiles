#! /usr/bin/env bash

unset start config_file_path add_to_list remove_list

if [ ${EUID:-${UID}} = 0 ]; then
    echo "ERROR"
    exit 1
fi

if [ "${MY_OS}" = "" ]; then
    MY_OS=`uname 2>&1`
fi

if [ ${MY_OS} = "Darwin" ]; then
    # macOS
    config_file_path="${HOME}/Library/Application Support/Code/User"
else
    # Linux
    config_file_path="${HOME}/.config/Code/User"
fi

echo ""
echo -ne "${MY_ESC_CODE}[1;39mstart update vscode settings and plugins?: ${MY_ESC_CODE}[0;39m"
echo -n "y-or-other: "
read start
if [ -z ${start} ] || [ $start != "y" ]; then
    echo "vscode config update passed!!"
else
    echo ""
    echo "----- update settings.json, keybindings.json -----"

    if [ -d "${config_file_path}" ]; then
        rm -f "${config_file_path}/settings.json"   ; ln -s ~/config_files/vscode/settings.json     "${config_file_path}/settings.json"
        rm -f "${config_file_path}/keybindings.json"; ln -s ~/config_files/vscode/keybindings.json  "${config_file_path}/keybindings.json"
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
    else
        echo ""
        echo "----------------- update plugins -----------------"
        cp ~/config_files/vscode/plugin_list.txt ~/config_files/vscode/plugin_list_tmp.txt && \
            code --list-extensions >> ~/config_files/vscode/plugin_list_tmp.txt && \
            cat ~/config_files/vscode/plugin_list_tmp.txt | sort | uniq > ~/config_files/vscode/plugin_list_currend_merged.txt && \
            rm -f ~/config_files/vscode/plugin_list_tmp.txt

        for i in $(cat ~/config_files/vscode/plugin_list_currend_merged.txt)
        do
            cat ~/config_files/vscode/plugin_list.txt | grep -q ${i}
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
                    echo ${i} >> ~/config_files/vscode/plugin_add_tmp_list.txt
                fi
                echo "-----"
            fi
        done

        rm -f ~/config_files/vscode/plugin_list_currend_merged.txt

        if [ -f ~/config_files/vscode/plugin_add_tmp_list.txt ]; then
            echo ""
            cat ~/config_files/vscode/plugin_add_tmp_list.txt >> ~/config_files/vscode/plugin_list.txt
            rm ~/config_files/vscode/plugin_add_tmp_list.txt
            cat ~/config_files/vscode/plugin_list.txt | sort | uniq > ~/config_files/vscode/plugin_list_tmp.txt
            rm ~/config_files/vscode/plugin_list.txt
            mv ~/config_files/vscode/plugin_list_tmp.txt ~/config_files/vscode/plugin_list.txt
        fi

        cp ~/config_files/vscode/plugin_list.txt ~/config_files/vscode/plugin_list_.txt
        for i in $(cat ~/config_files/vscode/plugin_list_.txt)
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
                    cat ~/config_files/vscode/plugin_list.txt | grep -v "${i}" > ~/config_files/vscode/plugin_list_tmp.txt
                    rm ~/config_files/vscode/plugin_list.txt
                    mv ~/config_files/vscode/plugin_list_tmp.txt ~/config_files/vscode/plugin_list.txt
                    # sed -i "" "/${i}/d" ~/config_files/vscode/plugin_list.txt
                fi
                echo "--"
            fi
        done

        rm ~/config_files/vscode/plugin_list_.txt

    fi
    unset start config_file_path add_to_list remove_list
    echo ""
    echo "vscode config updated!!"
fi
