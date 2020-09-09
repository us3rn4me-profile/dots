# Sxhkd
`Sxhkd` - демон хоткеев. Он служит для того, чтобы исполнять команды при нажатии каких-либо клавиш. Некоторые интересные моменты я буду приводить здесь, дабы пользователь не был в замешательстве, как та или иная функция работает.
## Super + i: Сделать все окна на рабочем столе плавающими или расстянутыми

`Файл: changeLayoutAllWindows.sh`

Это была одна из тех фич, о которых я всегда мечтал в `bspwm`, однако изначально её не было. Всё это можно сделать с помощью скрипта, однако скриптов в интернете тоэе нет, поэтому мне пришлось написать свой:

```bash
#!/usr/bin/env bash
# Проверка на то, в каком состоянии окно (летающее, расширенное)
floating=$(bspc query -N -n focused.floating);
if [[ $floating == "" ]]; then
	operation="floating";
else
	operation="tiled";
fi
# Делаем так, чтобы все дальнейшние окна были противоположны состоянию текущего
bspc rule -a \* desktop=focused state=${operation};
# Меняем состояние всех окон на противоположное текущему
for i in  $(bspc query -N -n .window -d focused); do
	bspc node ${i} -t ${operation};
done
# Триггер нужен только для того, чтобы знать в какой момент нужно повернуть направо, а когда вниз
trigger=true;
# Делаем разметку окон как в оригинале
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
```

`Файл: volume.sh`

Данный файл писался только для того, чтобы хоть немного решить проблему с огромной командой, которая сменяет громкость в sxhkd

```bash
#!/usr/bin/env bash
# Даём айдишники всем нашим уведомлениям, чтобы они могли сменять друг-друга
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
# Проигрываем аудиосигнал, который обычно мы слышим при смене звука
canberra-gtk-play -i audio-volume-change -d "changeVolume" -V 10
```

`Файл: setFlag.sh`

Данный скрипт писался для того, чтобы динамически менять флаги у окон (закреплённое, заблокированное, приватное)

```bash
#!/usr/bin/env bash
# Находим окна, которые сейчас сфокусированны (активны)
current=$(bspc query -N -n focused)
variant1="Toggle window sticky flag"
variant2="Toggle window locked flag"
variant3="Toggle window private flag"
variant4="Toggle window marked flag"
# Перебираем все варианты через rofi -dmenu
choice=$(echo -e "$variant1\n$variant2\n$variant3\n$variant4" | rofi -dmenu)
# Делаем что-либо при выборе пункта в rofi
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
```
