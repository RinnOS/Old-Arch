#!/usr/bin/env bash

echo "#############################"
echo "## INSTALLING AUR PACKAGES ##"
echo "#############################"
echo

if [ ! -f /usr/bin/yay ]; then
    cd "${HOME}"
    echo "Cloning YAY"
    git clone https://aur.archlinux.org/yay.git
    
    cd ${HOME}/yay
    makepkg -si

    cd ${HOME}/RinnOS
fi

I=0
while [ ! $I -eq $(yq '.aur | length' packages.yaml) ]; do
    PKG=$(yq .aur[$I] packages.yaml)

    echo "Installing $PKG"
    yay -S --noconfirm $PKG
    ((I++))
done

echo "###########"
echo "## DONE! ##"
echo "###########"