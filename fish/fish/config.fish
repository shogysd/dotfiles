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


if [ -f '~/.config/fish/imports/environments.fish' ];
    . '~/.config/fish/imports/environments.fish'
else
    echo "~/.config/fish/imports/environments.fish : No such file"
end

if [ -f '~/.config/fish/imports/aliases.fish' ];
    . '~/.config/fish/imports/aliases.fish'
else
    echo "~/.config/fish/imports/aliases.fish : No such file"
end

if [ -f '~/dotfiles/docker/docker.fish' ];
    . '~/dotfiles/docker/docker.fish'
else
    echo "~/dotfiles/docker/docker.fish : No such file"
end

# gcloud
if [ -f '~/google-cloud-sdk/path.fish.inc' ];
    . '~/google-cloud-sdk/path.fish.inc'
else
    echo "~/google-cloud-sdk/path.fish.inc : No such file"
end
