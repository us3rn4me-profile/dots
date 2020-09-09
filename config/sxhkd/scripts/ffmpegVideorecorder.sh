file="$HOME/Videos/$(date +%d-%m-%y_%H:%M:%S).mp4"
dunstify -p -r 5050 "Video" "Framerate"
fps=$(echo -e "15\n30\n40\n60" | rofi -dmenu -theme ~/.config/rofi/GreatSetFlag.rasi)
dunstify -p -r 5050 "Video" "Sound capture"
#withSound=$(echo -e "Yes\nNo" | rofi -dmenu -theme ~/.config/rofi/GreatSetFlag.rasi)
resolution=$(xrandr -q | grep "Screen 0" | awk '{print $8$9$10}' | sed -e 's/,//g')
# command
ffmpeg -f x11grab -r $fps -s $resolution -i :0.0 -q:v 0 -q:a 0  $file
