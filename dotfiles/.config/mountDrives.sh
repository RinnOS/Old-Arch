#!/usr/bin/env bash

# The labels for the drives to mount, will also create a folder for each drive with the same name.
DRIVELABELS=(
    'Vault'
    'BigDrive'
    'Data'
)

for label in "${DRIVELABELS[@]}"; do
    echo "Creating folder for ${label}"
    sudo mkdir /mnt/"${label}"
    echo
    echo "Mounting ${label} drive"
    sudo mount /dev/disk/by-label/"${label}" /mnt/"${label}"
    echo
done