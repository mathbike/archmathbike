#!/bin/bash

# archmathbike

# update pacman
pacman -Syu --noconfirm
# install packages
pacman -S --noconfirm base-devel linux-headers linux-firmware xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxft libxinerama xclip alsa-utils pulseaudio ttf-jetbrains-mono vim man-db git github-cli gnupg pass passmenu
# clone dwm, st, dmenu
git clone git://git.suckless.org/dwm ~/.config/dwm
git clone git://git.suckless.org/st ~/.config/st
git clone git://git.suckless.org/dmenu ~/.config/dmenu
# make dwm, st, dmenu
cd ~/.config/dwm && sudo make install
cd ~/.config/st && sudo make install
cd ~/.config/dmenu && sudo make install
# clone config files



# install yay
git clone https://aur.archlinux.org/yay-git.git ~/.config/yay
# make yay
cd yay && makepkg -si --noconfirm
# install brave
yay -S brave-bin
# install lf
yay -S lf
# install bash-complete-alias
yay -S bash-complete-alias

