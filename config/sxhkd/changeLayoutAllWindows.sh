#!/usr/bin/env bash
floating=$(bspc query -N -n focused.floating);
if [[ $floating == "" ]]; then
	operation="floating";
else
	operation="tiled";
fi
# Adding new rule
bspc rule -a \* desktop=focused state=${operation};
for i in  $(bspc query -N -n .window -d focused); do
	bspc node ${i} -t ${operation};
done

# Fibonacci-like placement
trigger=true;

for i in  $(bspc query -N -n .window -d focused); do
	if $trigger; then
		bspc node -f east;
		bspc node @parent -R 90
		trigger=false;
	else
		bspc node -f south;
		bspc node @parent -R -90
		trigger=true;
	fi
done
