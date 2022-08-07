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

sudo cp ./files/locale.gen /etc/locale.gen
sudo cp ./files/locale.conf /etc/locale.conf

sudo locale-gen

sudo mkdir /etc/openal
sudo cp ./files/alsoft.conf /etc/openal/alsoft.conf

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

echo 
echo "Enabling services..."
sudo systemctl enable sddm

# Tell the user that a reboot is needed then to continue afterwards
echo "Reboot is required to finish installation."
echo "Please reboot and continue to run these scripts again afterwards."
echo "Press enter to continue."
read
reboot
