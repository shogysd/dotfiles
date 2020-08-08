function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l color_normal (set_color normal)
    set -l color_cwd $fish_color_cwd
    set -l prefix
    set -l suffix '$'

    if contains -- $USER root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end

    # prompt_status
    set -l prompt_status (__fish_print_pipestatus '[' '] ' '|' (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    ###
    echo ""
    echo -n $USER@(prompt_hostname)' '
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1
        # in the git
        echo -s ' ( ' (git_status) ' ' (git_repopath) ' ) < ' (git_branch) ' | ' (git_hash) ' >'
    else
        # out of the git
        echo -s ' ( ' (prompt_pwd) ' )'
    end
    # shell only
    # echo -s 'fish ' (prompt_virtualenv_envwriter) $prompt_status $suffix ' '
    # major only
    # echo -s (fish --version | tr -d ',' | tr '.' ' ' | awk -F ' ' '{printf "%s-%s", $1, $3}') ' ' (prompt_virtualenv_envwriter) $prompt_status $suffix ' '
    # major and '.x'
    echo -s (fish --version | tr -d ',' | tr '.' ' ' | awk -F ' ' '{printf "%s-%s.x", $1, $3}') ' ' (prompt_virtualenv_envwriter) $prompt_status $suffix ' '
    # full-print
    # echo -s (fish --version | tr -d ',' | awk -F ' ' '{printf "%s-%s", $1, $3}') ' ' (prompt_virtualenv_envwriter) $prompt_status $suffix ' '
end
