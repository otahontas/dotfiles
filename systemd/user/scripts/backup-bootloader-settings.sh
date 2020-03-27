#!/bin/sh
/usr/bin/rsync -a /boot/loader $XDG_CONFIG_HOME/boot
exit_status=$?
if [[ $exit_status -ne 0 ]]; then
    exit 1;
fi
notify-send "Successfully backed up bootloader settings"
exit 0;
