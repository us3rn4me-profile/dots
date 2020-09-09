#!/usr/bin/env bash
# Hotkeys
sxhkd &
# Cursor
xsetroot -cursor_name left_ptr &
# Wallpaper
feh --bg-scale $HOME/.wallpapers/$(ls $HOME/.wallpapers | sort | shuf -n 1) &
# Compositor
killall -q picom; picom --config $HOME/.config/picom.conf &
# Languages
setxkbmap -layout us,ru -option grp:win_space_toggle &
# Terminal
kitty &
# USB handler
udiskie &
# Notification manager
dunst &
# Redshift
killall redshift || killall redshift-gtk; redshift-gtk -x & redshift-gtk -c $HOME/.config/redshift.conf &
# Thunar Daemon
thunar --daemon &
