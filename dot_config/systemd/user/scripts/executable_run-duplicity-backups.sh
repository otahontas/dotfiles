#!/bin/sh
backupdisk=/run/media/otahontas/archis_backup/
if [[ -e $backupdisk ]]; then
    notify-send "Backing up /home and /etc" "gpg-agent authentication possibly needed"
    # Pinentry-qt needs DISPLAY env var in order to be able to ask for password
    key=$(env DISPLAY=":0" pass keys/archis_backup)
    PASSPHRASE=$key duplicity /etc file://$backupdisk/etc
    etc_backup_exit_status=$?
    PASSPHRASE=$key duplicity --exclude /home/otahontas/.cache /home/otahontas/ file://$backupdisk/home
    home_backup_exit_status=$?
    if [[ $etc_backup_exit_status -ne 0 || $home_backup_exit_status -ne 0 ]]; then
        notify-send "Error happened while doing backup" "Backing up either /home, /etc or both failed"
        exit 1;
    fi
else
    notify-send "Disk wasn't connected, didn't perform backup"
    exit 1;
fi
notify-send "Successfully backed up /home and /etc to external disk"
exit 0;