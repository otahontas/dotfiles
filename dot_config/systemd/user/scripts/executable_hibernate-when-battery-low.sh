#!/bin/sh
acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
  read -r status1 capacity1
  read -r status2 capacity2
  if [ "$status1" = Discharging -o "$status2" = Discharging ] && [ "$capacity1" -lt 10 -a "$capacity2" -lt 10 ]; then
    notify-send "Critical battery threshold: battery under 10%" "Hibernating in 10 seconds"
		logger "Critical battery threshold"
    sleep 10
	  systemctl hibernate
  elif [ "$status1" = Discharging -o "$status2" = Discharging ] && [ "$capacity1" -lt 15 -a "$capacity2" -lt 15 ]; then
    notify-send "Low battery: battery under 15%" "System will hibernate soon"
	fi
}
