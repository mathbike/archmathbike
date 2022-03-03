#!/bin/bash

git clone https://github.com/mathbike/.dotfiles.git ~/tmpdotfiles
cd ~/tmpdotfiles

# delete dotfiles of the same name as those we already have:
# list all dotfiles and save to temp txt file, remove . and ..
ls -d .* | awk '$1 != "." {print $1}' >> ~/1.txt
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

