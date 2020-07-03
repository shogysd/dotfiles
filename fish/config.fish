set -x MY_OS (uname 2>&1)

# env
if [ $MY_OS = "Darwin" ]
    # macOS
    export MY_ESC_CODE='\033'
    export MY_DOWNLOAD_COMMAND='curl -s -o'
    # export BASH_SILENCE_DEPRECATION_WARNING=1
else
    # Linux
    export MY_ESC_CODE='\e'
    export MY_DOWNLOAD_COMMAND='wget -q -O'
end

if [ -f ~/.config/fish/imports/environments.fissh ]
    source ~/.config/fish/imports/environments.fish
end

if [ -f ~/.config/fish/imports/aliases.fissh ]
    source ~/.config/fish/imports/aliases.fish
end
