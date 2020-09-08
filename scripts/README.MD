# Scripts
Данный файл нужен для того, чтобы описать все скрипты находящиеся в этой папке. Скрипты играют абсолютно разные роли, их вызов будет описан в каждом разделе скрипта

## ChangeWallpaper_kde.sh
Скрипт, для того, чтобы менять обои на случайные из папки `.wallpaper`
```bash
#!/usr/bin/env bash
# variables
file=$(ls $HOME/.wallpapers | shuf -n 1) # Выбираем любые обои из ~/.wallpapers
echo "Making $file wallpaper on KDE"

# main
dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var Desktops = desktops();
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = "org.kde.image";
        d.currentConfigGroup = Array("Wallpaper",
                                    "org.kde.image",
                                    "General");
        d.writeConfig("Image", "file://'${HOME}/.wallpapers/${file}'");
}'
```
Следует также отдельно рассмотреть скрипт, который идёт в команде после `#main`
```javascript
// Выбираем все рабочие столы
var Desktops = desktops();
// Для каждого рабочего стола выполняем:
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i]; // Из массива десктопов достаём первый
        d.wallpaperPlugin = "org.kde.image"; // Достаём плагин обоев
        d.currentConfigGroup = Array("Wallpaper",
                                    "org.kde.image",
                                    "General");
        // Выбираем обои
        d.writeConfig("Image", "file://'${HOME}/.wallpapers/${file}'");
```
