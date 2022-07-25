#!/usr/bin/env bash

echo "#################################"
echo "## INSTALLING FLATPAK PACKAGES ##"
echo "#################################"
echo

# Check that flatpak is installed and can be used
if ! command -v flatpak >/dev/null 2>&1; then
	echo "Flatpak is not installed. Please install it and try again."
	exit 1
fi

I=0
while [ ! $I -eq $(yq '.flatpak | length' packages.yaml) ]; do
    PKG=$(yq .flatpak[$I] packages.yaml)

    echo "Installing $PKG"
    flatpak install --noninteractive $PKG
    ((I++))
done

echo "###########"
echo "## DONE! ##"
echo "###########"
