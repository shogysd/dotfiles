function git_repopath --description 'Print the path in git repository (customised), shortened to fit the prompt'
    set -l options 'h/help'
    argparse -n prompt_pwd --max-args=0 $options -- $argv
    or return

    if set -q _flag_help
        __fish_print_help prompt_pwd
        return 0
    end

    # This allows overriding fish_prompt_pwd_dir_length from the outside (global or universal) without leaking it
    set -q fish_prompt_pwd_dir_length
    or set -l fish_prompt_pwd_dir_length 3

    # Replace $HOME with "~"
    set git_repo_path (git rev-parse --show-toplevel)
    set git_repo_name (git rev-parse --show-toplevel | xargs basename)
    set git_repo_relative_path (git rev-parse --show-prefix)
    set -l tmp (string replace -r '^'"$git_repo_path"'($|/)' '$1' $PWD)

    # print
    echo -n $git_repo_name
    if [ $fish_prompt_pwd_dir_length -eq 0 ] || [ $fish_prompt_pwd_dir_length -gt (echo $tmp | wc -c) ]
        echo $tmp
    else
        # Shorten to at most $fish_prompt_pwd_dir_length characters per directory
        string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1_/' $tmp
    end
end
