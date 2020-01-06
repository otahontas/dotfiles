#!/bin/sh
echo "// Symlinking font configs from /etc/fonts/conf.avail/"
destfolder=$XDG_CONFIG_HOME/fontconfig/conf.d
configlist=$destfolder/fontconfigs
while read F; do
    # Parse comments out
    if [[ ${F:0:1} != '#' ]]; then
        [[ -e $destfolder/$F ]] || ln -s /etc/fonts/conf.avail/$F $destfolder/
    fi
done < $configlist
echo "Done"

echo "// Symlinking fonts folder to XDG_DATA_HOME"
dest=$XDG_DATA_HOME/fonts
[[ -e $dest ]] || ln -s $XDG_CONFIG_HOME/fonts $XDG_DATA_HOME/
echo "Done"

echo "// Symlinking gnupg config to GNUPGHOME"
dest=$GNUPGHOME/gpg-agent.conf
[[ -e $dest ]] || ln -s $XDG_CONFIG_HOME/gnupg/gpg-agent.conf $GNUPGHOME/
echo "Done"

echo "// Symlinking pacman hooks to /usr/share/libalpm/hooks/"
destfolder=/usr/share/libalpm/hooks
for f in $XDG_CONFIG_HOME/pacman-hooks/*.hook; do
    name=$(echo $f | xargs -n 1 basename)
    [[ -e $destfolder/$name ]] || sudo ln -s $f $destfolder/
done
echo "Done"
