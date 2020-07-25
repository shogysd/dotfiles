#! /usr/bin/env bash

if [ ! -d ~/dotfiles ]; then
    mkdir ~/dotfiles
fi
pushd ~/dotfiles > /dev/null
zips_dirname=zips-$(date +"%Y%m%d_%H%M%S")
rm -rf zips*; mkdir ${zips_dirname}

for i in $(ls -d ~/dotfiles/*/ | grep -v 'zips' | xargs basename)
do
    zip -rq ${zips_dirname}/${i}.zip ${i}
done

unset zips_dirnam
popd > /dev/null
