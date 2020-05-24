#!/bin/sh
dest=$XDG_DATA_HOME/chezmoi/arch_install/boot
[[ -e $dest ]] || mkdir -p $dest
/usr/bin/rsync -a /boot/loader/* $dest
rm $dest/random-seed
chmod -x $dest/loader.conf
chmod -x $dest/entries/arch.conf

exit_status=$?
if [[ $exit_status -ne 0 ]]; then
    notify-send "Failed to back up bootloader settings"
    exit 1;
fi
notify-send "Successfully backed up bootloader settings"
exit 0;
