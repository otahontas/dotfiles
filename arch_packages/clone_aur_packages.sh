#!/bin/bash
[[ -e ~/aur ]] || mkdir ~/aur
cd ~/aur
while read F; do
    if pacman -Qs $F > /dev/null ; then
        echo "$F is already installed"
    else
        [[ -e ~/aur/$F/ ]] || git clone https://aur.archlinux.org/$F.git
        echo "$F cloned and ready to be installed"
    fi
done < arch_foreignpkglist.txt
