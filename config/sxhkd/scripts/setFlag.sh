#!/usr/bin/env bash
# Script for making windows sticky, visible above others and other things
# Hidden, locked, private, sticky, marked
current=$(bspc query -N -n focused)
variant1="Toggle window sticky flag"
variant2="Toggle window locked flag"
variant3="Toggle window private flag"
variant4="Toggle window marked flag"
choice=$(echo -e "$variant1\n$variant2\n$variant3\n$variant4" | rofi -dmenu -matching fuzzy -markup -lines 5 -font "Lato 16" -sort -lines 10 -theme $HOME/.config/rofi/GreatSetFlag.rasi)
case $choice in
	$variant1)
		bspc node $current -g sticky
		;;
	$variant2)
		bspc node $current -g locked
		;;
	$variant3)
		bspc node $current -g private
		;;
	$variant4)
		bspc node $current -g marked
		;;
esac
