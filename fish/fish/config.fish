# env
if [ (uname 2>&1) = "Darwin" ]
    # macOS
    export OSDEP_ESC_CODE='\033'
    export OSDEP_DOWNLOAD_COMMAND='curl -s -o'
    # export BASH_SILENCE_DEPRECATION_WARNING=1
else
    # Linux
    export OSDEP_ESC_CODE='\e'
    export OSDEP_DOWNLOAD_COMMAND='wget -q -O'
end

source ~/.config/fish/imports/environments.fish
source ~/.config/fish/imports/aliases.fish
