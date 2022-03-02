#!/bin/bash

# archmathbike

# update pacman
sudo pacman -Syu --noconfirm
# install packages
sudo pacman -S --noconfirm base-devel linux-headers linux-firmware xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxft libxinerama xclip alsa-utils pulseaudio ttf-jetbrains-mono vim man-db git github-cli gnupg pass passmenu
# clone dwm, st, dmenu
git clone https://github.com/mathbike/dwm.git ~/.config/dwm
git clone https://github.com/mathbike/st.git ~/.config/st
git clone https://github.com/mathbike/dmenu.git ~/.config/dmenu
# make dwm, st, dmenu
cd ~/.config/dwm && sudo make install
cd ~/.config/st && sudo make install
cd ~/.config/dmenu && sudo make install && cd
# clone directoriesi
git clone https://github.com/mathbike/commands.git
git clone https://github.com/mathbike/scripts.git
# clone config files
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/mathbike/dotfiles.git ~/tmpdotfiles
rsync --recursive --verbose --exclude '.git' ~/tmpdotfiles/ $HOME/
rm -r ~/tmpdotfiles
# install yay
git clone https://aur.archlinux.org/yay-git.git ~/.config/yay
# make yay
cd ~/.config/yay && makepkg -si --noconfirm
# install brave
yay -S brave-bin --noconfirm
# install lf
yay -S lf --noconfirm
# install bash-complete-alias
yay -S bash-complete-alias --noconfirm

