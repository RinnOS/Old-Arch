#!/usr/bin/env bash

echo "##############################"
echo "## INSTALLING BASE PACKAGES ##"
echo "##############################"
echo


sudo pacman -Syu go-yq --noconfirm

I=0
while [ $I -le $(yq '.base | length' packages.yaml) ]; do
    PKG=$(yq .base[$I] packages.yaml)
    echo "Installing $PKG"
    sudo pacman -S $PKG --noconfirm --needed
    ((I++))
done

I=0
while [ $I -le $(yq '.drives | length' config.yaml) ]; do
    DRIVE=$(yq .drives[$I] config.yaml)

    if [ ! -d "/mnt/$DRIVE" ]; then
        echo "Creating folder /mnt/$DRIVE"
        sudo mkdir "/mnt/$DRIVE"
    fi

    sudo echo LABEL=$DRIVE /mnt/$DRIVE auto defaults 0 0 >> /etc/fstab

    ((I++))
done

# sudo cat <<EOF >> /etc/fstab
# # RinnOS
# LABEL=$()

# EOF

#echo "Mounting drives"
#sh ./dotfiles/scripts/mountDrives.sh

echo "###########"
echo "## DONE! ##"
echo "###########"