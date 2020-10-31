function venv(){
    if [ -z ${VIRTUAL_ENV} ] && [ $# = 1 ] && [ -f ${1}/bin/activate ]; then
        source ${1}/bin/activate
    elif [ ! -z ${VIRTUAL_ENV} ] && [ $# = 0 ]; then
        deactivate
    else
        echo "error: please check argument and virtualenv root path."
    fi
}


function screen_status(){
    screen -ls | grep Attached | tr '.' ' ' | echo -e "${OSDEP_ESC_CODE}[1;32m`awk '{printf "%s %s\t(Attached)\n", $1, $2}'`${OSDEP_ESC_CODE}[0;39m"
    screen -ls | grep Detached | tr '.' ' ' | awk '{printf "%s %s\t(Detached)\n", $1, $2}'
}


function strcmp(){
    if [ $# = 0 ]; then
        echo "error: nothing arguments"
        return 1
    elif [ $# = 1 ]; then
        echo "error: inadequate arguments"
        return 1
    elif [ $# -gt 2 ]; then
        echo "error: many arguments"
        return 1
    else
        if [ "$1" = "$2" ]; then
            echo "True"
        else
            echo "False"
        fi
    fi
    return 0
}


function addpath(){
    if [ $# = 0 ]; then
        target=$(pwd)
    elif [ $# -gt 1 ]; then
        echo "error: many arguments"
    else
        target=$(cd ${1} && pwd)
    fi
    declare -a path_list=();
    path_list=${PATH//:/ };

    for path in ${path_list[@]};
    do
        if [ "${target}" = "$path" ]; then
            echo "${target} is already exist in \$PATH"
            return 1
        fi
    done
    export PATH=${target}":"${PATH}
    echo ${target}" is added"
    return 0
}


function screen-clean(){
    echo -n "cleanup detached screen?: y-or-other: "
    read start
    if [ -z ${start} ] || [ ${start} != "y" ]; then
        echo "EXIT"
    else
        for id in `screen -ls | grep -e '(' -e ')' | tr '.' ' ' | grep 'Detached' | awk '{print $1}'`; do
            screen -S ${id} -X quit
        done
    fi
    unset start
}


function pd(){
    if [ $# = 0 ]; then
        popd
    elif [ $# = 1 ]; then
        pushd ${1}
    else
        echo "error: arg error"
    fi
}


function hosts-switch(){
    if [ -f /etc/hosts ] && [ -f /etc/hosts_BAK ] && [ "$( cat /etc/hosts | grep '# disable mode' )" ]; then
        echo "currently disabled"
        echo -n "change to enable?: y-or-other: "
        read start
        if [ -z ${start} ] || [ ${start} != "y" ]; then
            return 1
        fi
        # disable to enable
        sudo rm -f /etc/hosts && \
        sudo mv /etc/hosts_BAK /etc/hosts
        echo "/etc/hosts enabled"
    elif [ -f /etc/hosts ] && [ ! -f /etc/hosts_BAK ] && [ "$( cat /etc/hosts | grep -v '# disable mode' )" ]; then
        echo "currently enabled"
        echo -n "change to disable?: y-or-other: "
        read start
        if [ -z ${start} ] || [ ${start} != "y" ]; then
            return 1
        fi
        # enable to disable
        sudo mv /etc/hosts /etc/hosts_BAK && \
        sudo sh -c "echo '# disable mode' > /etc/hosts" && \
        sudo sh -c "echo '127.0.0.1       localhost'     >> /etc/hosts" && \
        sudo sh -c "echo '255.255.255.255 broadcasthost' >> /etc/hosts" && \
        sudo sh -c "echo '::1             localhost'     >> /etc/hosts"
        echo "/etc/hosts disabled"
    else
        echo error
    fi
    unset start
}


function gitignore_global-switch(){
    if [ ! -f ~/.gitignore_global ] && [ -f ~/.gitignore_global_BAK ]; then
        # disable to enable
        mv ~/.gitignore_global_BAK ~/.gitignore_global
    elif [ -f ~/.gitignore_global ] && [ ! -f ~/.gitignore_global_BAK ]; then
        # enable to disable
        mv ~/.gitignore_global ~/.gitignore_global_BAK
    else
        echo error
    fi
}
