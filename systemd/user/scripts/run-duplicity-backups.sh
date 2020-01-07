#!/bin/sh
duplicity /etc file:///media/backup/etc --no-encryption
duplicity --exclude /home/otahontas.cache /home/otahontas file:///media/backup/home --no-encryption
