#!/usr/bin/env bash
## ek9/x11-scripts - https://github.com/ek9/x11-scripts
set -e

command_exists() {
    command -v "$1" >/dev/null 2>&1;
}

_notify() {
    DISPLAY=:1
    notify-send -u normal -t 2000 -a media "$1"
}

_error() {
    DISPLAY=:1
    notify-send -u critical -t 2000 -a media "$1"
    exit 1
}

_call() {
    playerctl $@
    _notify "$@"
}

! command_exists "playerctl" && _error "playerctl is not installed"


_call "$@"
