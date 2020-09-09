#!/usr/bin/env bash
# Themes are switching by a time
# From 8PM to 7AM - Night theme
# From 7AM to 8PM - Day theme

kittyDIR="$HOME/.config/kitty"
rofiDIR="$HOME/.config/rofi"
theme="day"; #Fallback
if [[ $(date +%H) -lt 7 ]] || [[ $(date +%H) -gt 20 ]]; then
	echo Night
	theme="night"
	theme_alt="dark"

elif [[ $(date +%H) -lt 12 ]] && [[ $(date +%H) -gt 6 ]]; then
	echo Morning
	theme="morning"
	theme_alt="light"
else
	echo Day
	theme="day"
	theme_alt="light"
fi


# Theming
#? Xresources
ln -sf $HOME/.Xresources_${theme} $HOME/.Xresources
xrdb -load $HOME/.Xresources
#? Kitty
cat $kittyDIR/kitty_basis > $kittyDIR/kitty.conf && cat $kittyDIR/kitty_${theme} >> $kittyDIR/kitty.conf
#? Rofi (Start app)
ln -sf $rofiDIR/{themes/GreatBSPWM/GreatBSPWM_${theme},GreatBSPWM.rasi}
#? Rofi (Window changer)
ln -sf $rofiDIR/{themes/GreatTabber/GreatTabber_${theme},GreatTabber.rasi}
#? Rofi (Set Flag)
ln -sf $rofiDIR/{themes/GreatSetFlag/GreatSetFlag_${theme},GreatSetFlag.rasi}

#? GTK
#? >= 3.0
if [[ $theme_alt == "dark" ]]; then
	sed -i -e "s/gtk-theme-name=Materia-light/gtk-theme-name=Materia-dark/g" $HOME/.config/gtk-3.0/settings.ini
else
	sed -i -e "s/gtk-theme-name=Materia-dark/gtk-theme-name=Materia-light/g" $HOME/.config/gtk-3.0/settings.ini
fi

#? >= 2.0 && < 3.0
