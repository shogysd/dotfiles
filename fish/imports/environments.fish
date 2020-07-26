set -x fish_user_paths $HOME/bin
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -x VISUAL ':'
set -x EDITOR 'emacs'

# PATH
if [ (uname 2>&1) = "Darwin" ] && [ ! (echo $PATH | grep "/Library/Frameworks/Python.framework/Versions/") ]
    # macOS
    set -x PATH (find /Library/Frameworks/Python.framework/Versions/* -maxdepth 1 -name bin | sort -r | head -n 1) $PATH
# else
    # Linux
end
