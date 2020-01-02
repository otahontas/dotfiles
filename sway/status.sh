# Idle status
idle=""
if [[ $(pgrep swayidle) == "" ]]; then
    idle="☕ On"
fi

# Audio
volume_status=$(amixer | grep "Front Left: Playback" | sed -E 's/(^|\])[^[]*($|\[)/ /g' | cut -d' ' -f3)
if [[ $volume_status == 'off' ]]; then
    volume="🔇 Muted"
else 
    volume="🔊 $(amixer | grep "Front Left: Playback" | sed -E 's/(^|\])[^[]*($|\[)/ /g' | cut -d' ' -f2)"
fi

# Batteries for two battery Thinkpad T480
batt0=$(acpi | grep "Battery 0" | cut -d',' -f1-2 | cut -d':' -f2)
batt1=$(acpi | grep "Battery 1" | cut -d',' -f1-2 | cut -d':' -f2)
battery="⚡ $batt0 | $batt1"

# Wifi
wifi_status=$(rfkill | grep phy0 | sed -E 's/( )+/,/g' | cut -d',' -f5)
if [[ $wifi_status == "blocked" ]]; then
    wifi="📡 Wifi off"
else
    wifi_name=$(iw dev | grep ssid | cut -c8-)
    if [[ $wifi_name == "" ]]; then
        wifi_name="Wifi not connected"
    fi
    wifi="📡 $wifi_name"
fi

# Kb layout
kb="⌨️ $(swaymsg -t get_inputs | jq '.[3].xkb_active_layout_name' | sed -E 's/"//g' | cut -d' ' -f1)"

# Date
datetime="⏰ $(date +'%Y-%m-%d %l:%M %p')"

# Finalize output
echo $idle $volume $wifi $battery $kb $datetime
