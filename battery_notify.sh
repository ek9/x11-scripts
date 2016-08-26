#!/usr/bin/env bash
## ek9/x11-scripts - https://github.com/ek9/x11-scripts
#xrandr &> /dev/null
export STATUS=$(/usr/bin/acpi -b)
export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER/bus

notify-send -u normal -t 2000 -a battery "$(/usr/bin/acpi -b)"
echo $STATUS
if [[ $STATUS == *"Discharging"* ]]; then
    xsetroot -solid "#000000"
else
    nitrogen --restore
fi
