#!/usr/bin/env bash

echo "##############################"
echo "## INSTALLING BASE PACKAGES ##"
echo "##############################"
echo


sudo pacman -Syu go-yq

I=0
while [ $I -le $(yq '.base | length' packages.yaml) ]; do
    PKG=$(yq .base[$I] packages.yaml)
    echo "Installing $PKG"
    sudo pacman -S $PKG --noconfirm --needed
    ((I++))
done

echo "Mounting drives"
sh ./dotfiles/scripts/mountDrives.sh

echo "###########"
echo "## DONE! ##"
echo "###########"