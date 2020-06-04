if [ ${MY_OS} = "Darwin" ]; then
    # macOS
    function open(){
        if [ $# = 0 ]; then
            $(which open) ./
        else
            $(which open) ${@}
        fi
    }
else
    # Linux
    function open(){
        if [ $# = 0 ]; then
            $(which nautilus) ./
        else
            $(which nautilus) ${@}
        fi
    }
fi


function ssh(){
    if [ $# != 1 ]; then
        echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
        echo "\$# is $# ( not 1 )"
        exec "$(which ssh) ${@}"
        sleep 1
        $(which ssh) ${@}
    else
        $(which ssh) ${1} test -f .bash_local
        if [ ! $? = 0 ]; then
            $(which scp) -q ~/config_files/ssh_config_files/ssh_config_files.zip ${USER}@${1}: && \
            $(which ssh) ${USER}@${1} "unzip -o -qq ~/ssh_config_files.zip && ~/config_files/setup.sh"
        fi
        $(which ssh) ${USER}@${1}
    fi
}


function pip(){
    if [ -z ${VIRTUAL_ENV} ]; then
        echo -ne "${MY_ESC_CODE}[1;33mWARNING: ${MY_ESC_CODE}[0;39m"
        echo "virtualenv is not activated!!"
        echo -ne "${MY_ESC_CODE}[1;39mcontinue ?: ${MY_ESC_CODE}[0;39m"
        echo -n "y-or-other: "
        read start
        if [ -z ${start} ] || [ "${start}" != "y" ]; then
            unset start
            return 1
        fi
        unset start
        $(which python3) -m pip ${@}
        return $?
    fi
}


function code(){
    if [ $# = 0 ]; then
        $(which code) ./
    else
        $(which code) ${@}
    fi
}
