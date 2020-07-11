#! /usr/bin/env bash

if [ ! -d ~/config_files ]; then
    mkdir ~/config_files
fi
pushd ~/config_files > /dev/null
zips_dirname=zips-$(date +"%Y%m%d_%H%M%S")
rm -rf zips*; mkdir ${zips_dirname}

for i in $(ls -d ~/config_files/*/ | grep -v 'zips' | xargs basename)
do
    zip -rq ${zips_dirname}/${i}.zip ${i}
done

unset zips_dirnam
popd > /dev/null
