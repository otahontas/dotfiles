#!/bin/sh
/usr/bin/rsync -a /etc/iwd $XDG_CONFIG_HOME/etc
/usr/bin/rsync -a /etc/mkinitcpio.conf $XDG_CONFIG_HOME/etc
/usr/bin/rsync -a /etc/systemd/system/ $XDG_CONFIG_HOME/etc/systemd/
/usr/bin/rsync -a /etc/systemd/user $XDG_CONFIG_HOME/etc/systemd/
/usr/bin/rsync -a /etc/udev/hwdb.d $XDG_CONFIG_HOME/etc/udev
