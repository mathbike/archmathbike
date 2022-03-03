#!/bin/bash

# archmathbike

# update
sudo pacman -Syu --noconfirm
# install packages
sudo pacman -S --noconfirm base-devel linux-headers linux-firmware xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxft libxinerama xclip alsa-utils pulseaudio ttf-jetbrains-mono gvim man-db git github-cli gnupg pass passmenu bashtop

git clone https://github.com/mathbike/.dotfiles.git ~/tmpdotfiles
cd ~/tmpdotfiles

# delete dotfiles of the same name as those we already have:
# list all dotfiles and save to temp txt file, remove . and ..
ls -d .* | awk '$1 != "." {print $1}' >> 1.txt
cat 1.txt | awk '$1 != ".." {print $1}' >> ~/2.txt
# cd home
cd ~
# loop variables
file="2.txt"
lines=$(cat $file)
# delete loop
for line in $lines
do
	rm -rf ${line}
done
# delete temp txt files
rm -rf 1.txt 2.txt  ~/tmpdotfiles

# clone config files
git clone --bare https://github.com/mathbike/.dotfiles.git ~/.dotfiles
# temp config
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# checkout repo
config checkout
# untracked files
config config --local status.showUntrackedFiles no

# clone directories
git clone https://github.com/mathbike/bookmarks.git
git clone https://github.com/mathbike/commands.git
git clone https://github.com/mathbike/scripts.git
# rename Downloads
mv Downloads dl

# dwm
git clone https://github.com/mathbike/dwm.git ~/.config/dwm
cd ~/.config/dwm && sudo make install
# dwmblocks
git clone https://github.com/mathbike/dwmblocks.git ~/.config/dwmblocks
cd ~/.config/dwmbocks && sudo make install
# st
git clone https://github.com/mathbike/st.git ~/.config/st
cd ~/.config/st && sudo make install
# dmenu
git clone https://github.com/mathbike/dmenu.git ~/.config/dmenu
cd ~/.config/dmenu && sudo make install && cd

# yay
git clone https://aur.archlinux.org/yay-git.git ~/.config/yay
cd ~/.config/yay && makepkg -si --noconfirm
# brave
yay -S brave-bin --noconfirm
# lf
yay -S lf --noconfirm

