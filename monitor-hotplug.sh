#!/bin/bash
# Based on https://bbs.archlinux.org/viewtopic.php?pid=1047415#p1047415
# Script for toggling different monitor setups for laptop. Supports these modes:
# - Default mode: Laptop monitor only ($LVDS) and external monitors off
# - External VGA mode: Laptop monitor ($LVDS) and external monitor ($EXT1)
# - External HDMI mode: Laptop monitor ($LVDS) and external monitor ($EXT2)
# - External only mode: External monitor ($EXT1) and external monitor ($EXT2)

# run only once
PIDFILE=/run/user/$UID/monitor-hotplug.pid
# run xrandr a few times so it refreshes
#xrandr &> /dev/null
#xrandr &> /dev/null

# Laptop's monitor
LVDS="LVDS1"
# EXT1 monitor
EXT1="DP1"
# HDMI monitor
EXT2="VGA1"
MONITOR_FILE='/tmp/monitor-hotplug'
LID='/proc/acpi/button/lid/LID/state'
[ ! -f "$MONITOR_FILE" ] && touch "$MONITOR_FILE"
DISPLAY=:1

function _notify() {
    notify-send -u normal -t 2000 -a display "$1"
}

function external_only() {
   _notify "external displays $EXT1 and $EXT2"
    xrandr --output $LVDS --off
    xrandr --output $EXT1 --auto --primary
    xrandr --output $EXT2 --auto --right-of $EXT1
}

function external_ext1() {
    echo ext1
    if [ $LID_OPEN == false ]; then
        _notify "external display $EXT1 only"
        xrandr --output $EXT1 --auto --primary
        xrandr --output $EXT2 --off --output $LVDS --off
    else
        _notify "externdal display $EXT1 and $LVDS"
        xrandr --output $EXT2 --off
        xrandr --output $LVDS --auto \
            --output $EXT1 --auto --right-of $LVDS --primary
    fi
}

function external_ext2() {
    echo ext2
    if [ $LID_OPEN == false ]; then
        _notify "external display $EXT2 only"
        xrandr --output $EXT2 --auto --primary
        xrandr --output $EXT1 --off --output $LVDS --off
    else
        _notify "external display $EXT2 and $LVDS"
        xrandr --output $EXT1 --off
        xrandr --output $LVDS --auto \
            --output $EXT2 --auto --right-of $LVDS --primary
    fi
}

monitor_setup() {
    CHK_EXT2=$(xrandr |grep $EXT1 | awk ' { print $2 } ')
    CHK_EXT1=$(xrandr |grep $EXT2 | awk ' { print $2 } ')

    LID_STATUS=$(cat $LID)
    LID_OPEN=true
    [[ $LID_STATUS == *"closed"* ]] && LID_OPEN=false


    #CHK_EXT2_G=$(xrandr |grep $EXT1 | grep "+")
    #CHK_EXT1_G=$(xrandr |grep $EXT2 | grep "+")

    if [ "$CHK_EXT2" == "connected" ] && [ "$CHK_EXT1" == "connected" ]; then
        external_only
    elif [ "$CHK_EXT2" == "connected" ]; then
        external_ext1
    elif [ "$CHK_EXT1" == "connected" ]; then
        external_ext2
    else
        xrandr --output $LVDS --auto --primary --output $EXT1 --off --output $EXT2 --off
    fi

    # restore wallpapers if nitrogen is installed
    command -v nitrogen >/dev/null 2>&1 && nitrogen --restore

    # restart i3
    i3-msg restart
}

monitor_setup

# run only once
if [ -f "$PIDFILE" ] && kill -0 $(cat $PIDFILE) 2>/dev/null; then
    exit 0
fi
echo $$ > $PIDFILE


while inotifywait "$MONITOR_FILE"; do
    monitor_setup
done
