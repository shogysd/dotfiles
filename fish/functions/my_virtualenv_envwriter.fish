function my_virtualenv_envwriter
    if [ ! -z "$VIRTUAL_ENV" ]
        echo -n '[ venv: '(echo -n $VIRTUAL_ENV | xargs basename)' ] '
    end
end
