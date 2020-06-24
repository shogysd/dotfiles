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
    if test ! -z (git status --porcelain) > /dev/null 2>&1
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

    echo -nes "\033[" $style_code $front_color_code $background_color_code $attribute_code "mgit:\033[0;39m"
end
