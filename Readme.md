# Дотфайлы
Дотфайлы - конфигурации для Linux-утилит и программ. Дотфайлами они называются потому что в Unix-подобных системах все файлы начинающиеся с `.` - скрыты (dotfiles).

# Основная конфигурация

## Общая конфигурация

Общая конфигурация в основном касается консоли.

Включены конфигурации следующих утилит:

* Neofetch
* Neovim
* Ranger
* Mocp
* Konsole
* htop

## KDE

<div align="center">
<img src="assets/activeDesktop.png" alt="Desktop"/>
</div>

<div align="center">
<img src="assets/neofetch.png" alt="neofetch info"/>
</div>
* Шрифты: *JetBrains Mono*, *Lato*

* Иконки: McMojave-Circle-Blue
* Цвета и детализация окон: McMojave
* Цветовая палитра консоли: us3rn4me-colorscheme

* Панель: LatteDock (с моей схемой)

Все конфигурационные файлы, которые относятся к сборке **KDE**:

* config/lattedockrc
* config/albert
* config/Typora

### Подготовка к установке dotfile'ов

```bash
sudo pacman -Sy neofetch htop neovim latte-dock plasma ttf-lato ttf-jetbrains-mono konsole dolphin spectacle base-devel albert flatpak
```

```bash
# Часть с yay
yay -Sy google-chrome typora
```
