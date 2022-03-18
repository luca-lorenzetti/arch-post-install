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

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  
  exit
fi

CURRENTUSER=$LOGNAME
 
### Update system
echo "Update the system"

pacman -Syy -y --noconfirm && pacman -Syu --noconfirm

#### Install paru
echo "Installation paru"

# 1) install git and base-devel for paru
	echo "install git and  base-devel"
	pacman -S --needed git base-devel --noconfirm

# 2) Clone repo and create folder paru
	git clone https://aur.archlinux.org/paru.git /home/$CURRENTUSER/
	
	# enter into paru folder and make
	cd paru
	makepkg -si
	
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

