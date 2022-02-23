#! /usr/bin/env bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@ SCRIPT POST INSTALLATION @@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@((@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@(((/@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@(((((/@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@(((((((/@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@(((((((((//@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@////(((((((//@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@/////////((((//@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@//@@//////////(//@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@////////@///////////@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@///////////////////////@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@*****///////////////////*@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@*******(((((((((((((((((((/@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@****((((((((((((((((((((((((((@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@(((((((((((((((@@@(((((((((((((((@@@@@@@@@@@@@
@@@@@@@@@@@@@(((((((((((((@@@@@@@@@(((((((((((((@@@@@@@@@@@@
@@@@@@@@@@@((((((((((((((@@@@@@@@@@@(((((((((((((@@@@@@@@@@@
@@@@@@@@@@((((((((((((((@@@@@@@@@@@@@((((((((((((((@@@@@@@@@
@@@@@@@@@(((((((((((((((@@@@@@@@@@@@@(((((((((((@@((@@@@@@@@
@@@@@@@(((((((((((((((((@@@@@@@@@@@@@(((((((((((((((@@@@@@@@
@@@@@@(((((((((((((((@@@@@@@@@@@@@@@@@@@(((((((((((((((@@@@@
@@@@((((((((((@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(((((((((@@@@
@@@((((((@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@((((((@@
@@((@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@((@
                                                            "

### Check if user is root

#if [ "$EUID" -ne 0 ]
#  then echo "Please run as root"
  
#  exit
#fi

CURRENTUSER=$LOGNAME

su 
### Update system
echo "Update the system"

pacman -Syy -y --noconfirm && pacman -Syu --noconfirm

#### Install yay
echo "Installation yay"

# 1) install git and base-devel for yay
	echo "install git and  base-devel"
	pacman -S --needed git base-devel --noconfirm

# 2) Clone repo and create folder yay
	git clone https://aur.archlinux.org/yay.git /home/$CURRENTUSER/
	
	# enter into yay folder and make
	cd yay
	sudo -u nobody makepkg -si
	
####  Install packages from packages.list (PACMAN)

cat packages.list | xargs pacman -S --noconfirm


#### Install packages from packagesaur.list (AUR)

yay --save --answerclean All --answerdiff All

cat packages.list | xargs yay -S --noconfirm

### Copy .conf folder

cp -r .config /home/$CURRENTUSER/

### Copi Immagini folder

cp -r Immagini /home/$CURRENTUSER/



echo 'fine'

