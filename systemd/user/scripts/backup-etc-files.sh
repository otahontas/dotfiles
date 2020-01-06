#!/bin/sh
/usr/bin/rsync -a /etc/mkinitcpio.conf $XDG_CONFIG_HOME/etc
/usr/bin/rsync -a /etc/udev/hwdb.d $XDG_CONFIG_HOME/etc/udev
