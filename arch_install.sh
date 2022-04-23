#! /usr/bin/env bash

echo "////////////////////////////////////////////
/////////// SCRIPT POST INSTALLATION /////////////
//////////////////////////////////////////////////"

pacman -S parted --noconfirm


# delete partition
for i in 10
do
	parted -s /dev/sda rm $i
done


#Create partition

parted -s /dev/sda mkpart primary ext4 0% 100%


mkfs.ext4 /dev/sda1

pacman -Syy

mount /dev/sda1 /mnt

pacstrap /mnt base linux linux-firmware sudo nano

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime

echo 'it_IT.UTF-8 UTF-8' >> /etc/locale.gen

locale-gen

echo LANG=it_IT.UTF-8 > /etc/locale.conf
export LANG=it_IT.UTF-8

echo arch-test > /etc/hostname

echo "root:root" | chpasswd -e

pacman -S grub --noconfirm

grub-install /dev/sda

grub-mkconfig -o /boot/grub/grub.cfg

