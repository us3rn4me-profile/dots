#!/usr/bin/env bash

# TextDecorations
bold=$(tput bold)
normal=$(tput sgr0)
underline=$(tput smul)
greencolor=$(tput setaf 2)

# Functions
echo -e "\n";
function warning() { # Check if user under root
	echo "${bold}DO NOT START THIS SCRIPT AS SUDO
	YOU CAN EXIT BY ENTERING CTRL-C FOR 10 SECONDS
	IF EVERYTHING OK, THAN JUST GO ON${normal}"
		sleep 10
	}

function install_yay() { # Install yay
	sudo pacman -Sy git base-devel
	cd $HOME
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ../
	rm -rf yay
	yay_pack
}

function yay_pack() { # Install yay packages
	yay -Sy google-chrome
	yay -Sy polybar
	yay -Sy typora
}

function install_zsh() { # Install zsh + oh-my-zsh
	sudo pacman -Sy --noconfirm zsh
	sudo chsh $USER -s /usr/bin/zsh
	curl https://raw.githubusercontent.com/us3rn4me-profile/TheGreatestBSPWM/master/zshrc --output $HOME/.zshrc
}

function install_nvim {
	warning
	sudo pacman -Sy python-pynvim neovim
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
			# Copying nvimrc
			cp config/nvim/ $HOME/.config/nvim -r
		}

	function init() { # Init copy of configurations
		warning
		cd $HOME
		git clone https://github.com/us3rn4me-profile/dots.git
		cd dots
		# Config install TODO: Make config function
		config
		# Wallpapers
		mkdir $HOME/.wallpapers
		unzip wallpapers/wallpapers.zip ~/.wallpapers/
		# Xresources
		cp Xresources_{day,night,morning} $HOME/
		mv $HOME/{,.}Xresources_morning
		mv $HOME/{,.}Xresources_day
		mv $HOME/{,.}Xresources_night
	}

function config() {
	echo -e "Choose your config:\n1 - KDE;\n2 - BSPWM"
	read userchoice
	case $userchoice in
		"1")
		# KDE
			sudo pacman -Sy pavucontrol p7zip unrar okular elisa xorg xclip xorg-xinit plasma dolphin ark konsole cmake powerdevil npm neofetch spectacle bluez bluez-utils task albert libunrar python
		;;
		"2")
	# BSPWM
		sudo pacman -Sy --noconfirm bspwm sxhkd rofi dunst xautolock lightdm lightdm-webkit2-greeter picom udiskie pavucontrol feh sxiv redshift kitty nvim ttf-jetbrains-mono ttf-lato fzf scrot ttf-font-awesome imagemagick nautilus alsa-lib alsa-utils xdg-user-dirs networkmanager ranger ffmpeg pulseaudio vlc materia-gtk-theme pulseaudio-alsa pulseaudio-bluetooth telegram-desktop raw-thumbnailer xarchiver zathura-djvu zathura-ps zathura-cb zathura-pdf-poppler zathura npm zip unzip python-pynvim ttf-dejavu xorg grub git fuse curl bluez bluez-utils tlp moc xclip flatpak
		sudo systemctl enable lightdm.service # Window manager by default
		sudo tlp start
		# Copying config for TheGreatestBSPWM
		cp config/{zathura,rofi,sxhkd,bpswm,dunst,picom.conf,kitty,ranger,mimeapps.list,zathura,redshift.conf} $HOME/.config/
		;;
	esac
}


if [[ -z $1 ]]; then
	warning
	init
	sudo systemctl enable NetworkManager.service # Network manager for wifi connecting
	sudo systemctl enable bluetooth.service # Bluetooth connect

# Installing software and configurations
install_yay
install_zsh

# Make default directories
xdg-user-dirs-update

elif [[ "$1" = "-h" ]] || [[ "$1" = "--help" ]]; then
	echo -e "${bold}Usage${normal}:
	./full_install.sh - install all configurations
	./full_install.sh [${underline}Function${normal}] - install part of config"

	echo -e "\n${bold}Functions${normal}:
	${greencolor}install_yay${normal}  - install yay (with Google Chrome and Polybar)
	${greencolor}install_zsh${normal}  - install zsh config with oh-my-zsh
	${greencolor}init${normal}         - install configuration
	${greencolor}install_nvim${normal} - install nvim configuration"

else
	$1
fi
echo -e "\n"
