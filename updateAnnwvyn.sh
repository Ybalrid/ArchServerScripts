#!/bin/bash

cd Annwvyn/doxygen/
gitOutput=$(git pull GitHub master)

if [ "$gitOutput" = "Already up-to-date." ]
then
    echo "Nothing to do. Documentation is up to date!"
else
    echo "Remove old ouptut and rerun doxygen, then copy content to website workdir"
    rm -rvf Gen
    doxygen Doxy*
    cp -rv Gen/html/* /home/vhost/annwvyn/api/
fi

