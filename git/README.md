# git config command list

## common ( macOS(Darwin) and Linux)

```
git config --global include.path          '~/.gitconfig_userinfo'
git config --global include.path          '~/config_files/git/gitconfig_envdep_ln'

git config --global core.excludesfile     '~/.gitignore_global'
git config --global core.pager            less

git config --global color.ui              true
git config --global core.autocrlf         input

# git config --global push.default        nothing
git config --global push.default          simple

git config --global fetch.prune           'true'

git config --global alias.br              'branch -v'
git config --global alias.cl              'clone'
git config --global alias.cla             'clone --recursive'
git config --global alias.co              'checkout'
git config --global alias.comm            '!git rev-parse --is-inside-work-tree > /dev/null && cd $(git rev-parse --show-toplevel) && git commit'
git config --global alias.df              'diff'
git config --global alias.di              'diff'
git config --global alias.diffname        'diff --name-only'
git config --global alias.diffword        'diff --word-diff'
git config --global alias.din             'diff --name-only'
git config --global alias.diw             'diff --word-diff'
git config --global alias.gd              '!cd $(git rev-parse --show-toplevel)'
git config --global alias.gr              'grep -n'
git config --global alias.grepn           'grep -n'
git config --global alias.hash            'rev-parse --short HEAD'
git config --global alias.repoup-origin   '!git fetch origin && git reset --hard origin/$(git symbolic-ref --short refs/remotes/origin/HEAD | xargs basename)'
git config --global alias.repoup-upstream '!git fetch origin && git reset --hard upstream/$(git symbolic-ref --short refs/remotes/origin/HEAD | xargs basename)'
git config --global alias.st              'status'
git config --global alias.sub             'submodule update --init --recursive'
```

## macOS(Darwin) only

```
git config --global core.editor '/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
git config --global alias.ad '!git rev-parse --is-inside-work-tree > /dev/null && cd $(git rev-parse --show-toplevel) && xattr -cr && find . -name .DS_Store | xargs rm -rf && git add .'
```

## Linux only

```
git config --global core.editor 'emacs -nw'
git config --global alias.ad '!git rev-parse --is-inside-work-tree > /dev/null && cd $(git rev-parse --show-toplevel) && git add .'
```
