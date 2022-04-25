#! /usr/bin/env bash

echo "////////////////////////////////////////////
/////////// SCRIPT POST INSTALLATION /////////////
//////////////////////////////////////////////////"


echo "/// INSTALL PARTED PACKAGE ///"
pacman -S parted --noconfirm


# delete partition
echo "/// REMOVE ALL PARTITION ///"
for i in {1..10}
do
	parted -s /dev/sda rm $i
done


#Create partition

echo "/// CREATE ROOT PARTITION ///"
parted -s /dev/sda mkpart primary ext4 0% 100%

echo "/// MKFS EXT4 ///"
mkfs.ext4 /dev/sda1

echo "/// UPDATE PACMAN ///"
pacman -Syy

echo "/// MOUNT MNT ///"
mount /dev/sda1 /mnt

echo "/// PACSTRAP MAIN PACKAGES ///"
pacstrap /mnt base linux linux-firmware sudo nano

echo "/// GENFSTAB ///"
genfstab -U /mnt >> /mnt/etc/fstab

echo "/// CHROOT ///"
arch-chroot /mnt

echo "/// LN LOCALTIME ///"
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime

echo "/// UTF8 ///"
echo 'it_IT.UTF-8 UTF-8' >> /etc/locale.gen

echo "/// LOCALE-GEN ///"
locale-gen

echo "/// LANG ITALIAN ///"
echo LANG=it_IT.UTF-8 > /etc/locale.conf

echo "/// EXPORT LANG///"
export LANG=it_IT.UTF-8

echo "/// SET HOSTNAME ///"
echo arch-test > /etc/hostname

echo "/// PASSWORD ROOT ///"
echo "root:root" | chpasswd -e

echo "/// PACMAN INSTALL GRUB ///"
pacman -S grub --noconfirm

echo "/// START GRUB-INSTALL ///"
grub-install /dev/sda

echo "/// START GRUB-MKCONFIG ///"
grub-mkconfig -o /boot/grub/grub.cfg

