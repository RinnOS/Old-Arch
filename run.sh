#!/usr/bin/env bash

# Make sure script was run with sudo but not as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo but not as root."
    exit 1
fi

loopScript=true

while $loopScript; do
    clear
    
    echo "What would you like to do?"
    echo "1. Install base packages"
    echo "2. Install software packages"
    echo "3. Install AUR packages"
    echo "4. Install AppImages"
    echo "5. Run post-installation script"
    echo "6. Run all"
    echo "7. Exit"
    echo
    read -p "Enter your choice: " choice

    # If they chose to install base packages, run the base-packages.sh script.
    if [ $choice -eq 1 ]; then
        sudo sh 1-base.sh || exit 1
    fi

    # If they chose to install software packages, run the software-packages.sh script.
    if [ $choice -eq 2 ]; then
        sudo sh 2-software-pacman.sh || exit 1
    fi

    # If they chose to install AUR packages, run the aur-packages.sh script.
    if [ $choice -eq 3 ]; then
        sh 3-software-aur.sh || exit 1
    fi

    # If they chose to install AppImages, run the appimage-packages.sh script.
    if [ $choice -eq 4 ]; then
        sh 4-software-appimage.sh || exit 1
    fi

    # If they chose to run the post-installation script, run the post-setup.sh script.
    if [ $choice -eq 5 ]; then
        sudo sh 9-post-setup.sh || exit 1
    fi

    # If they chose to run all, run the base-packages.sh script, then the software-packages.sh script, then the aur-packages.sh script, then the appimage-packages.sh script.
    if [ $choice -eq 6 ]; then
        # Ask the user if they're sure they want to run all.
        echo "Are you sure you want to run all? (y/n)"
        read sure
        if [ $sure == "y" ]; then
            sudo sh 1-base.sh || exit 1
            sudo sh 2-software-pacman.sh || exit 1
            sh 3-software-aur.sh || exit 1
            sh 4-software-appimage.sh || exit 1
            sudo sh 9-post-setup.sh || exit 1
        fi
    fi

    # If they chose to exit, exit the loop.
    if [ $choice -eq 7 ]; then
        loopScript=false
    fi
done