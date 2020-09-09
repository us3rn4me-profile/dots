#!/usr/bin/env bash
# Giving an ID to replace previous notifications (-r flag)
function raise() {
	amixer -D pulse sset Master 5%+ && dunstify -r 701423 "Volume" "Volume added +5%\nVolume level is now $(amixer -D pulse get Master | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ print $3 }')" --urgency low
}

function lower() {
	amixer -D pulse sset Master 5%- && dunstify -r 701423 "Volume" "Volume added -5%\nVolume level is now $(amixer -D pulse get Master | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ print $3 }')" --urgency low
}

function mute() {
	amixer -D pulse sset Master toggle && dunstify -r 701423 "Volume" "Sound is (un)muted" --urgency low
}

case $1 in
	"raise")
		raise
		;;
	"lower")
		lower
		;;
	"mute")
		mute
		;;
esac
# Play audio
canberra-gtk-play -i audio-volume-change -d "changeVolume" -V 10
