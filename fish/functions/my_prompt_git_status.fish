function my_prompt_git_status
    # style code
    #   0: default
    #   1: bold
    # front color code
    #   39: normal
    #   31: red
    # background color code
    #   49: normal
    #   41: red
    # attribute code
    #   7: inversion

    set -l style_code "0"
    set -l front_color_code ";39"
    set -l background_color_code ""
    set -l attribute_code ""

    # gitrepo clean or not check
    if test (git status --porcelain | wc -l | xargs echo) != 0
        # branch is not clean
        set style_code "1"
        set front_color_code ";31"
    end

    # gitignore-global check
    if ! find ~/.gitignore_global > /dev/null 2>&1
        # gitignore-global disabled
        set attribute_code ";7"
        if test "$front_color_code" = ";31"
            set background_color_code ";47"
        end
    end

    echo -nes $MY_ESC_CODE"[" $style_code $front_color_code $background_color_code $attribute_code "mgit:"$MY_ESC_CODE"[0;39m"
end
