#!/bin/bash
screen=$(xrandr -q | grep DP-1 | grep " connected" | awk '{print $1}')
while :
do
	# an half hour
	notify-send "Display will turn off in 30 minutes" -u normal
	sleep 1680
	notify-send "Display will turn off in 2 minutes for 5 minutes" -u normal
	sleep 120
	# turn off display
	xrandr --output $screen --off
	sleep 300
	# turn on display
	xrandr --output $screen --auto
done
