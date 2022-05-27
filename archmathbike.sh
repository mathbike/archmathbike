#!/bin/bash

# archmathbike

# install packages:
packages() {
	sudo pacman -S --noconfirm \
		base-devel linux-headers linux-firmware \
		xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxft libxinerama xclip xorg-xinput \
		alsa-utils pulseaudio bashtop rsync \
		ttf-jetbrains-mono gvim man-db git github-cli \
		ufw gnupg pass passmenu python-pip xdotool \
		zathura zathura-pdf-mupdf youtube-dl brightnessctl nodejs npm code gimp inkscape tlp \
		texlive-most #linux-lts linux-lts-headers
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
	# clone .dotfiles
	git clone --bare https://github.com/mathbike/.dotfiles.git ~/.dotfiles
	# checkout repo
	/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
	# do not show untracked files
	/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME --local status.showUntrackedFiles no
}

# clone dotfiles:
dotfiles() {
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
	cd ~/.config/dmenu && sudo make install
}

# clone directories:
directories() {
	cd
	git clone https://github.com/mathbike/commands.git
	git clone https://github.com/mathbike/scripts.git
	git clone https://github.com/mathbike/browserconfig.git
}

# install aur package manager:
aurhelper() {
	# yay
	git clone https://aur.archlinux.org/yay-git.git ~/.config/yay
	cd ~/.config/yay && makepkg -si --noconfirm
}

# install aur packages:
aurpackages() {
	# brave
	cd
	yay -S brave-bin --noconfirm
	rm -rf  ~/.config/BraveSoftware/Brave-Browser/Default
	cp -r  ~/browserconfig/Default ~/.config/BraveSoftware/Brave-Browser
	# lf
	yay -S lf --noconfirm
}

# FreeCAD
freecad() {
	cd
	yay -S freecad-git --noconfirm
}

# openrazer
openrazer() {
	cd
	yay -S openrazer-meta --noconfirm
	# add user to plugdev
	gpasswd -a mike plugdev
	# then reboot
	# install GUI
	yay -S razercommander --noconfirm
}

# set symlinks:
symlinks() {
	ln -s ~/.config/dwmstatusbar/sb-battery.sh /usr/local/bin
	ln -s ~/.config/dwmstatusbar/sb-date.sh /usr/local/bin
	ln -s ~/.config/dwmstatusbar/sb-volume.sh /usr/local/bin
	ln -s ~/.config/dwmstatusbar/sb-brightness.sh /usr/local/bin
	ln -s ~/tlp.conf /etc/
}

# configure firewall
firewall() {
	sudo systemctl enable ufw.service
	sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw logging off
	sudo ufw enable
}	

# general housekeeping:
housekeeping() {
	cd
	# rename Downloads directory
	rm -rf Downloads && mkdir dl
	# set the timezone
	sudo timedatectl set-timezone America/Toronto
	# enable tlp
	sudo systemctl enable tlp.service
	# npm live server
	sudo npm install -g live-server
	# vimrc stuff
	rm -rf /etc/vimrc
	ln -s ~/.vimrc /etc/vimrc
	# zathurarc stuff
	mkdir ~/.config/zathura
	ln -s ~/zathurarc ~/.config/zathura
}

asus() {
	# disable touchscreen
	xinput -disable 13
	# disable webcam
	xinput -disable 12
}

hp() {
	# disable laptop display
	xrandr --output eDP-1 --off
	# disable touchscreen
	xinput -disable 15
	# disable webcam
	xinput -disable 13
       # disable IR camera
	xinput -disable 14       
}

T420() {
	:
}

X220() {
	:
}

#packages
#dotsdelete
#dotfiles
#configuration
#directories
#aurhelper
#aurpackages
#freecad
#openrazer
#symlinks
#firewall
#housekeeping
#asus
#hp
#T420
#X220

