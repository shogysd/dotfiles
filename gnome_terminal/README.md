# How to export
```
$ dconf dump /org/gnome/terminal/legacy/profiles:/ > [file_name]
```

# How to import
WARNING!! Existing profile will be deleted.
```
$ dconf reset -f /org/gnome/terminal/legacy/profiles:/
$ dconf load /org/gnome/terminal/legacy/profiles:/ < [file_name]
```
