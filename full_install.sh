#!/usr/bin/env bash

bold=$(tput bold)
normal=$(tput sgr0)
underline=$(tput smul)
greencolor=$(tput setaf 2)

echo -e "\n";
function warning() {
	echo "${bold}DO NOT START THIS SCRIPT AS SUDO
	YOU CAN EXIT BY ENTERING CTRL-C FOR 10 SECONDS
	IF EVERYTHING OK, THAN JUST GO ON${normal}"
	sleep 10
	}

function install_yay() {
	sudo pacman -Sy git base-devel
	cd $HOME
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ../
	rm -rf yay
}

function install_zsh() {
	sudo pacman -Sy --noconfirm zsh
	sudo chsh $USER -s /usr/bin/zsh
	curl https://raw.githubusercontent.com/us3rn4me-profile/TheGreatestBSPWM/master/zshrc --output $HOME/.zshrc
	yay_pack
}

function yay_pack() {
	yay -Sy google-chrome
	yay -Sy polybar
}

function GREATBSPWM() {
	warning
	cd $HOME
	git clone https://github.com/us3rn4me-profile/TheGreatestBSPWM.git
	cd TheGreatestBSPWM
	# Config install
	cp config $HOME/.config/ -r
	# Wallpapers
	mkdir $HOME/.wallpapers
	unzip wallpapers/wallpapers.zip ~/.wallpapers/
	# Xresources
	cp Xresources_{day,night,morning} $HOME/
	mv $HOME/{,.}Xresources_morning
	mv $HOME/{,.}Xresources_day
	mv $HOME/{,.}Xresources_night
}

function install_vim {
	warning
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	# Copying vimrc
	cp vimrc $HOME/.vimrc
	cp coc.vim $HOME/.coc.vim
}

if [[ -z $1 ]]; then
	warning
	sudo pacman -Sy --noconfirm bspwm sxhkd rofi dunst xautolock lightdm lightdm-webkit2-greeter picom udiskie pavucontrol feh sxiv redshift kitty vim ttf-jetbrains-mono ttf-lato fzf scrot ttf-font-awesome imagemagick nautilus alsa-lib alsa-utils xdg-user-dirs networkmanager ranger ffmpeg pulseaudio vlc materia-gtk-theme pulseaudio-alsa pulseaudio-bluetooth telegram-desktop raw-thumbnailer xarchiver zathura-djvu zathura-ps zathura-cb zathura-pdf-poppler zathura npm zip unzip python-pynvim ttf-dejavu xorg grub git fuse curl bluez bluez-utils tlp moc xclip flatpak

	sudo systemctl enable NetworkManager.service # Network manager for wifi connecting
	sudo systemctl enable bluetooth.service # Bluetooth connect
	sudo systemctl enable lightdm.service # Window manager by default
	sudo tlp start

# Installing software and configurations
install_yay
install_zsh
GREATBSPWM

# Make default directories
xdg-user-dirs-update

elif [[ "$1" = "-h" ]] || [[ "$1" = "--help" ]]; then
	echo -e "${bold}Usage${normal}:
	./full_install.sh - install all configurations
	./full_install.sh [${underline}Function${normal}] - install part of config"

	echo -e "\n${bold}Functions${normal}:
	${greencolor}install_yay${normal} - install yay (with Google Chrome and Polybar)
	${greencolor}install_zsh${normal} - install zsh config with oh-my-zsh
	${greencolor}GREATBSPWM${normal}  - install TheGreatestBSPWM configuration
	${greencolor}install_vim${normal} - install vim configuration"

else
	$1
fi
echo -e "\n"
