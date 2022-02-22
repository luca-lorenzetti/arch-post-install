#! /usr/bin/env bash


### Check if user is root

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  
  exit
fi


### Update system
echo "Update the system"

pacman -Syy -y && pacman -Syu -y

#### Install yay
echo "Installation yay"

# 1) install git and base-devel for yay
	echo "install git and  base-devel"
	pacman -S --needed git base-devel -y

# 2) Clone repo and create folder yay
	git clone https://aur.archlinux.org/yay.git
	
	# enter into yay folder and make
	cd yay
	makepkg -si
	
	
echo 'fine'

