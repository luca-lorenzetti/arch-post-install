#! /usr/bin/env bash

while IFS= read -r line; do

	if [[ $line == *"version"* ]]; then
  		version=$line;

	elif [[ $line == *"name"* ]]; then
  		name=$line;
	fi
done < version.txt

echo "////////////////////////////////////////////
/////////// SCRIPT POST INSTALLATION /////////////
////////// $version v.	$name		 /////////////
//////////////////////////////////////////////////"

### Check if user is root

#if [ "$EUID" -ne 0 ]
#  then echo "Please run as root"
#
#  exit
#fi

### Update system
echo "Update the system"

sudo pacman -Syy --noconfirm && sudo pacman -Syu --noconfirm

#### Install yay
echo "Installation yay"

# 1) install git and base-devel for yay
echo "install base-devel"
sudo pacman -S --needed base-devel --noconfirm

# 2) Clone repo and create folder yay
cd ~/
git clone https://aur.archlinux.org/yay.git

# enter into yay folder and make

cd yay

makepkg -si --noconfirm

sudo rm -R ~/yay

####  Install packages from packages.list (PACMAN)
cd ~/arch-xfce4-post-install
cat packages.list | xargs sudo pacman -S --noconfirm

#### Install packages from packagesaur.list (AUR)

yay --save --answerclean All --answerdiff None

cat packagesaur.list | xargs yay -S --noconfirm
#while read package; do
# yay -S $package --noconfirm
# done < packagesaur.list

echo "Enable the systemd service for lightdm"
sudo systemctl enable lightdm

### Copy .config folder
echo "Do you want copy .config folder?Y/n"

read configFolder

if [ "$configFolder" = "y" ] || [ "$configFolder" = "Y" ]; then

	sudo cp -r .config ~/

	echo "Copy .folder done."
else
	echo "Ok"
fi

### Copy .bashrc
echo "Copy .bashrc"
sudo cp -r .bashrc ~/

## Clean

sudo pacman -Rsn $(pacman -Qqdt) --noconfirm

echo 'The end and reboot'

reboot
