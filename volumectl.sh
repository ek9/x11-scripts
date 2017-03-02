#!/usr/bin/env bash
## volumectl.sh - controls volue via pactl. Used by i3 keybinds
set -e

command_exists() {
    command -v "$1" >/dev/null 2>&1;
}

_notify() {
    DISPLAY=:1
    VOL=$(pactl list sinks | grep "Volume: front"| awk '{print $5}')
    notify-send -u normal -t 100 -a volumectl "Volume $VOL ($1)"
}

_error() {
    DISPLAY=:1
    notify-send -u critical -t 100 -a volumectl "$1"
    exit 1
}

_vol_control() {
    pactl set-sink-volume 0 "$@"
    _notify "$@"
}

_vol_toggle() {
    pactl set-sink-mute 0 toggle
    _notify "Volume Mute"
}

_mic_toggle() {
    pactl set-source-mute 1 toggle
    _notify "Microphone Mute"
}


! command_exists "pactl" && _error "pactl is not installed"

if [ "$1" == "toggle-vol-mute" ]; then
    _vol_toggle
elif [ "$1" == "toggle-mic-mute" ]; then
    _mic_toggle
else
    _vol_control "$@"
fi
