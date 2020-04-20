#!/bin/sh
acpi -b | grep "Battery 0" | awk -F'[,:%]' '{print $2, $3}' | {
	read -r status capacity
    if [ "$status" = Discharging -a "$capacity" -lt 10 ]; then
		logger "Critical battery threshold"
        notify-send "Critical battery threshold: battery under 10%" "Hibernating in 10 seconds"
        sleep 10
		systemctl hibernate
    else 
        if [ "$status" = Discharging -a "$capacity" -lt 15 ]; then
            notify-send "Low battery: battery under 15%" "System will hibernate soon"
        fi
	fi
}
