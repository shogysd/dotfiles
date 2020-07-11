#! /usr/bin/env bash

if [ ! -d ~/config_files ]; then
    mkdir ~/config_files
fi
pushd ~/config_files
rm -rf zips; mkdir zips

for i in $(ls -d ~/config_files/*/ | grep -v 'zips' | xargs basename)
do
    zip -r ~/config_files/zips/${i}.zip ${i}
done

popd
