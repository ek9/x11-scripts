x11-scripts
===========

[x11-scripts][0] is a repository containing various shell (mostly bash)
scripts.

Part of [ek9/dotfiles][10] collection.

## Install

Clone to `~/.local/share/x11-scripts` via `git`:

    $ git clone https://github.com/ek9/x11-scripts ~/.local/share/x11-scripts

Add directory to path (`~/.profile`, `.bash_profile` or `.zprofile`):

    $ export PATH=$PATH:~/.local/share/x11-scripts

You will be able to execute the scripts.

## Scripts

- `battery_notify.sh` - send notification when battery is discharging + disable
   wallpaper.
- `brightnessctl.sh` - controll brightness (thinkpad x230)
- `lid-toggle.sh` - runs `monitor-hottplug.sh` on lit toggle + `sflock` on close 
- `monitor-hotplug.sh` - a script to toggle different monitor setups for laptop 
- `pdf-repair.sh` - pdf file repair utility
- `playerctl.sh` - playerctl wrapper with notifications
- `scot` - scrot wrapper to put screenshots in `~/images/screenshots`
- `steamfix.sh` - steam linked library fix utility
- `volumectl.sh` - pactl wrapper to control volume (used by i3 keybinds)
- `xvim` - open vim+terminal via X11 Xorg (i.e. thunar)

[0]: https://github.com/ek9/x11-scripts
[10]: https://github.com/ek9/dotfiles
