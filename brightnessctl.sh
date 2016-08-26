#!/bin/bash
set -e

command_exists() {
    command -v "$1" >/dev/null 2>&1;
}

_notify() {
    DISPLAY=:1
    BRG="$(printf "%.0f" "$(xbacklight -get)")"
    notify-send -u normal -t 100 -a brightnessctl "Brighness $BRG ($1)"
}

_error() {
    DISPLAY=:1
    notify-send -u critical -t 100 -a brightnessctl "$1"
    exit 1
}

_brg_control() {
    xbacklight $@
    _notify "$@"
}

! command_exists "xbacklight" && _error "xbacklight is not installed"

_brg_control "$@"
