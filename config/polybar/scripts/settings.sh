#!/usr/bin/env bash
# Menu options
menu=(" Power off" " Reboot" " Open sound settings (pavucontrol)" " Set HDMI as mirror screen" " Set HDMI as screen, that right of eDP-1" " Turn off HDMI")
rofi="rofi -dmenu -sort -matching glob -theme ~/.config/rofi/GreatSetFlag.rasi"
variable=""
for i in "${menu[@]}";
do variable="$variable$i\n";
done;
choice=$(echo -e $variable | $rofi)

case $choice in
	${menu[0]})
		# echo Poweroff
		poweroff;;
	${menu[1]})
		# echo Reboot
		reboot;;
	${menu[2]})
		# echo pavucontrol
		pavucontrol -t 5;;
	${menu[3]})
		# echo Mirror screens
		activeOutput=$(xrandr -q | grep DP-1 | grep " connected" | awk '{print $1}')
		selectedOutput=$(xrandr -q | grep " connected" | awk '{print $1}' | sed -e '/eDP/d' | $rofi)
		size=$(xrandr --current | grep "Screen 0" | awk '{print $8$9$10}' | sed -e 's/,//g')
		xrandr --output $selectedOutput --off;
		xrandr --output $activeOutput --primary --mode $size --scale 1x1 --output $selectedOutput --auto --mode $size --same-as $activeOutput >> /dev/null;;
	${menu[4]})
		# echo Right of *DP-1 screens
		activeOutput=$(xrandr -q | grep DP-1 | grep " connected" | awk '{print $1}')
		selectedOutput=$(xrandr -q | grep " connected" | awk '{print $1}' | sed -e '/eDP/d' | $rofi)
		xrandr --output $selectedOutput --off;
		xrandr --output $selectedOutput --auto --right-of $activeOutput >> /dev/null;;
	${menu[5]})
		# echo Turn off screens
		selectedOutput=$(xrandr -q | grep " connected" | awk '{print $1}' | $rofi)
		xrandr --output $selectedOutput --off;;
esac
