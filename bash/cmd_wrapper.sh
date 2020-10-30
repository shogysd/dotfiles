if [ "$(uname 2>&1)" = "Darwin" ]; then
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

function pip(){
    if [ -z ${VIRTUAL_ENV} ]; then
        echo -ne "${OSDEP_ESC_CODE}[1;33mWARNING: ${OSDEP_ESC_CODE}[0;39m"
        echo "virtualenv is not activated!!"
        echo -ne "${OSDEP_ESC_CODE}[1;39mcontinue ?: ${OSDEP_ESC_CODE}[0;39m"
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
