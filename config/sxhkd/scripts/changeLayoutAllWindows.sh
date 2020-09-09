#!/usr/bin/env bash
floating=$(bspc query -N -n focused.floating);
if [[ $floating == "" ]]; then
	operation="floating";
	bspc rule -r tail; # Deleting the rule
else
	operation="tiled";
	bspc rule -a \* desktop=focused state=tiled; # Adding the rule
fi
# Adding new rule
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
