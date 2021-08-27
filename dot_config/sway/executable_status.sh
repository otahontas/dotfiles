# Idle status
idle=""
if [[ $(pgrep swayidle) == "" ]]; then
    idle="☕ On"
fi

# Audio
## Volume
volume_status=$(amixer | grep "Front Left: Playback" | sed -E 's/(^|\])[^[]*($|\[)/ /g' | cut -d' ' -f3)
sink=$(pactl info | grep "Default Sink" | cut -d' ' -f3)
output_device="$(pactl list sinks | grep -e 'Name: '$sink -A 1 | grep "Description" | cut -d' ' -f2)"

if [[ $volume_status == 'off' ]]; then
    vol_level="🔇 Muted"
else
    vol_level="🔊 $(amixer | grep "Front Left: Playback" | sed -E 's/(^|\])[^[]*($|\[)/ /g' | cut -d' ' -f2)"
fi
volume="$vol_level | $output_device"

## Mic input
mic_status=$(amixer | grep "Front Left: Capture" | sed -E 's/(^|\])[^[]*($|\[)/ /g' | cut -d' ' -f3)
source=$(pactl info | grep "Default Source" | cut -d' ' -f3)
input_device="$(pactl list sources | grep -e 'Name: '$source -A 1 | grep "Description" | cut -d' ' -f2)"
if [[ $mic_status == 'off' ]]; then
    mic_level="🚫 Mic muted"
else
    mic_level="🎤 $(amixer | grep "Front Left: Capture" | sed -E 's/(^|\])[^[]*($|\[)/ /g' | cut -d' ' -f2)"
fi
mic="$mic_level | $input_device"

audio="$volume $mic"

# Bluetooth
bt_status=$(rfkill | grep tpacpi_bluetooth | sed -E 's/( )+/,/g' | cut -d',' -f5)
if [[ $bt_status == "blocked" ]]; then
    bt="🚫 Bt off"
else
    bt="🟦 Bt on"
fi


# Wifi
wifi_status=$(rfkill | grep phy0 | sed -E 's/( )+/,/g' | cut -d',' -f5)
if [[ $wifi_status == "blocked" ]]; then
    wifi="🚫 Wifi off"
else
    wifi_name=$(iw dev | grep ssid | cut -c8-)
    if [[ $wifi_name == "" ]]; then
        wifi_name="Wifi not connected"
    fi
    wifi="📡 $wifi_name"
fi

# Batteries for two battery Thinkpad T480
batt0=$(acpi | grep "Battery 0" | cut -d',' -f1-2 | cut -d':' -f2)
batt1=$(acpi | grep "Battery 1" | cut -d',' -f1-2 | cut -d':' -f2)
battery="🔋 $batt0 | $batt1"

# Date
datetime="⏰ $(date +'%Y-%m-%d %l:%M %p')"

# Finalize output
echo $idle $audio $bt $wifi $battery $datetime
