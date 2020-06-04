if [ ! -f ~/bin/shis ]; then
    function shis(){
        if [ $# = 1 ]; then
            history | \
                # sed '$d' | \
                awk -F '   ' '{ \
            if ( $2 ~ /.*'${1}'.*/ ) { \
                gsub("'${1}'", "\033[1;31m'${1}'\033[0;39m", $2); \
                printf "%s   %s\n", $1, $2; \
            } \
        }'
            # | tail -n 100 2>/dev/null
            return 0
        elif [ $# = 0 ]; then
            echo "error: nothing arguments"
            return 1
        else
            echo "error: many arguments"
            return 1
        fi
    }
fi
