#!/bin/sh
# From https://gist.github.com/othiym23/4ac31155da23962afd0e#file-npm-upgrade-sh
 
set -e
set -x
 
for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2)
do
    npm -g install "$package"
done