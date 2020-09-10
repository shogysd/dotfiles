function git_branch
    set -l git_branch (git symbolic-ref --short HEAD 2> /dev/null)
    if [ $status -eq 0 ]
        set -l default_branch (git symbolic-ref --short refs/remotes/origin/HEAD 2> /dev/null | xargs basename)
        # if [ $status -eq 0 ]
        #     set -l default_branch master
        # end
        if [ "$git_branch" = "$default_branch" ]
            echo -ne $OSDEP_ESC_CODE"[0;33m"$git_branch$OSDEP_ESC_CODE"[0;39m"
        else
            echo -ne "$git_branch"
        end
    else
        echo -ne $OSDEP_ESC_CODE"[0;36mdetached"$OSDEP_ESC_CODE"[0;39m"
    end
end
