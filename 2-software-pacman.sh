#!/usr/bin/env bash

echo "##################################"
echo "## INSTALLING SOFTWARE PACKAGES ##"
echo "##################################"
echo

sudo pacman -Sy
I=0

while [ ! $I -eq $(yq '.pacman | length' packages.yaml) ]; do
    PKG=$(yq .pacman[$I] packages.yaml)

    echo "Installing $PKG"
    sudo pacman -S $PKG --noconfirm --needed
    ((I++))
done

echo "###########"
echo "## DONE! ##"
echo "###########"