function git_hash
    set -l git_hash (git rev-parse --short HEAD 2> /dev/null)
    if [ $status -eq 0 ]
        echo -n $git_hash
    else
        echo -n "Not committed"
    end
end
