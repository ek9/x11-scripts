#!/usr/bin/env bash
## ek9/x11-scripts - https://github.com/ek9/x11-scripts
set -e

export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER/bus
export LID_STATUS=$(awk '{ print $2 }' /proc/acpi/button/lid/LID/state)
export NUM_DISPLAYS=$(xrandr -q |grep -c ' connected ')

~/.local/bin/monitor-hotplug.sh
notify-send -u normal -t 2000 -a laptop "lid $LID_STATUS $NUM_DISPLAYS"

if [ "closed" == "$LID_STATUS" ] && [ "$NUM_DISPLAYS" -lt 2 ]; then
    /usr/bin/slock -d
fi

