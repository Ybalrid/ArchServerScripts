#!/bin/bash

cd Annwvyn/doxygen/

rm -rvf Gen
doxygen Doxy*
cp -rv Gen/html/* /home/vhost/annwvyn/api/
