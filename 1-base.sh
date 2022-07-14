#!/usr/bin/env bash

# Make sure script was run with sudo but not as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo but not as root."
    exit 1
fi

echo "##############################"
echo "## INSTALLING BASE PACKAGES ##"
echo "##############################"
echo


sudo pacman -Syu go-yq --noconfirm

I=0
while [ ! $I -eq $(yq '.base | length' packages.yaml) ]; do
    PKG=$(yq .base[$I] packages.yaml)
    echo "Installing $PKG"
    sudo pacman -S $PKG --noconfirm --needed
    ((I++))
done

I=0
while [ ! $I -eq $(yq '.drives | length' config.yaml) ]; do
    DRIVE=$(yq .drives[$I] config.yaml)

    if [ ! -d "/mnt/$DRIVE" ]; then
        echo "Creating folder /mnt/$DRIVE"
        sudo mkdir "/mnt/$DRIVE"
    fi

    sudo cat << EOF >> /etc/fstab
LABEL=$DRIVE /mnt/$DRIVE auto defaults 0 0
EOF

    ((I++))
done

echo "###########"
echo "## DONE! ##"
echo "###########"