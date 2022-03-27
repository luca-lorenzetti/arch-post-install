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
read -p "Enter fullname: " CURRENTUSER

 
### Update system
echo "Update the system"

pacman -Syy -y --noconfirm && pacman -Syu --noconfirm

#### Install yay
echo "Installation yay"

# 1) install git and base-devel for yay
	echo "install git and  base-devel"
	pacman -S --needed git base-devel --noconfirm

# 2) Clone repo and create folder yay
	git clone https://aur.archlinux.org/yay.git /home/$CURRENTUSER/yay
	
	# enter into yay folder and make
	chmod -R 777 ../yay
	cd ../yay
	sudo -H -u $CURRENTUSER bash -c makepkg -si
	
####  Install packages from packages.list (PACMAN)
cd ../arch-post-install
sudo cat packages.list | xargs pacman -S --noconfirm


#### Install packages from packagesaur.list (AUR)

yay --save --answerclean All --answerdiff All

sudo cat packagesaur.list | xargs yay -S --noconfirm


### Copy .conf folder

cp -r .config /home/$CURRENTUSER/


## Start Plank Dock

plank

echo 'The end'

