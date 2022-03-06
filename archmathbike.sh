#!/bin/bash

# archmathbike

# install packages:
packages() {
	sudo pacman -S --noconfirm \
		base-devel linux-headers linux-firmware \
		xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxft libxinerama xclip \
		network manager alsa-utils pulseaudio bashtop rsync \
		ttf-jetbrains-mono gvim man-db git github-cli \
		gnupg pass passmenu zathura python-pip \
		zathura youtube-dl
}

# delete dotfiles that we already have:
dotsdelete() {
	# clone tmpdotfiles
	git clone https://github.com/mathbike/.dotfiles.git ~/tmpdotfiles && cd ~/tmpdotfiles
	# list all dotfiles and save to temp txt file, remove . and ..
	ls -d .* | awk '$1 != "." {print $1}' >> 1.txt
	cat 1.txt | awk '$1 != ".." {print $1}' >> ~/2.txt && cd ~
	# declare loop variables
	local file="2.txt" && local lines=$(cat $file)
	# run delete loop
	for line in $lines
	do
		rm -rf ${line}
	done
	# delete temp files
	rm -rf 2.txt  ~/tmpdotfiles
}

# clone dotfiles:
dotfiles() {
	git clone --bare https://github.com/mathbike/.dotfiles.git ~/.dotfiles
	# temp config alias
	alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
	# checkout repo
	config checkout
	# do not show untracked files
	config config --local status.showUntrackedFiles no
}

# install configuration:
configuration() {
	# dwm
	git clone https://github.com/mathbike/dwm.git ~/.config/dwm
	cd ~/.config/dwm && sudo make install
	# dwmblocks
	git clone https://github.com/mathbike/dwmblocks.git ~/.config/dwmblocks
	cd ~/.config/dwmblocks && sudo make install
	# dwmstatusbar
	git clone https://github.com/mathbike/dwmstatusbar.git ~/.config/dwmstatusbar
	# st
	git clone https://github.com/mathbike/st.git ~/.config/st
	cd ~/.config/st && sudo make install
	# dmenu
	git clone https://github.com/mathbike/dmenu.git ~/.config/dmenu
	cd ~/.config/dmenu && sudo make install && cd
}

# install aur package manager:
aur() {
	# yay
	git clone https://aur.archlinux.org/yay-git.git ~/.config/yay
	cd ~/.config/yay && makepkg -si --noconfirm
}

# install aur packages:
aurpackages() {
	# brave
	yay -S brave-bin --noconfirm
	rm -rf  ~/.config/BraveSoftware/Brave-Browser/Default
	cp -r  ~/bookmarks/Default ~/.config/BraveSoftware/Brave-Browser
	# lf
	yay -S lf --noconfirm
}

# clone directories:
directories() {
	git clone https://github.com/mathbike/bookmarks.git
	git clone https://github.com/mathbike/commands.git
	git clone https://github.com/mathbike/scripts.git	
}

# clone symlinks:
symlinks() {
	:
}

# configure firewall
firewall() {
	
}	

# general housekeeping:
housekeeping() {
	# rename Downloads directory
	rm -rf Downloads && mkdir dl
}

packages
dotsdelete
dotfiles
configuration
aur
aurpackages
directories
symlinks
firewall
housekeeping

