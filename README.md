# config_files

## how to use it

### step1: set environment variablesset
please set environment variable 'MY_REMOTE_GITHUB_ACCOUNT' and 'MY_CONF_MODE'
- MY_REMOTE_GITHUB_ACCOUNT
  - remote repository's account
- MY_CONF_MODE
  - config run mode ( OWNER or GUEST )

( repository name is 'config_files' )

example...
```
$ export MY_REMOTE_GITHUB_ACCOUNT='[ config_file's remote github account ]'
$ export MY_CONF_MODE='[ OWNER | GUEST ]'
```
or write to `~/.bash_local` and load it
```
export MY_REMOTE_GITHUB_ACCOUNT='[ config_file's remote github account ]'
export MY_CONF_MODE='[ OWNER | GUEST ]'
```
```
$ source ~/.bash_local
```
\[info\] `~/.bash_local` is autoloaded by bashrc and NOT autoremove when execute 'config-update' command

### step2: delete old directory and remote repository

- if: OWNER mode
```
$ \
rm -rf ~/config_files; \
git -C ~/ clone git@github.com:${MY_REMOTE_GITHUB_ACCOUNT}/config_files.git
```

### step3: load repository's config-update command
```
$ source ~/config_files/bash/config-update.sh
```

### step4: execute config-update command
```
$ config-update
```
