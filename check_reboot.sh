#!/bin/bash

#the end of the name of the kernel package to check 
#(leave -empty for `linux`, -lts for `linux-lts`...)
kernel="-lts"

#manipulate the string so it matches the output of uname -r. 
#e.g: add -lts at the end for the lts kernel
package_ver=$(pacman -Q linux$kernel | awk -v ext="$kernel" '{print $2ext}')
uname_ver=$(uname -r)

#show to the user the different versions
echo pacman installed: $package_ver
echo curently running: $uname_ver

#explicitely tell if you need to reboot to the new kernel or not
if [ "$package_ver" = "$uname_ver" ]; then
    tput setaf 2
    echo "no need to reboot"
else
    tput setaf 1
    tput bold
    echo "please reboot to use new kernel $package_ver"
fi
tput sgr0

