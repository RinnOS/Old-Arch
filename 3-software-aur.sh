#!/usr/bin/env bash

echo "#############################"
echo "## INSTALLING AUR PACKAGES ##"
echo "#############################"
echo

echo "Please enter username:"
read username

cd "${HOME}"

echo "Cloning YAY"
git clone https://aur.archlinux.org/yay.git

PKGS=(
    # --- Utilities ---
    'timeshift'
    'appimagelauncher'
    'optimus-manager'
    'optimus-manager-qt'
    'popsicle'
    'yt-dlg'
    'ventoy'
    'betterdiscordctl'

    # --- Audio/Video ---
    'pulsemeeter'
    'wtwitch'
    'ani-cli'
    'yt-dlp'

    # --- Development ---
    'visual-studio-code-bin'
    'gitfiend'
    'debtap'

    # --- Applications ---
    'freetube-bin'
    'obsidian'
    'protonvpn'
    'waterfox-g4-bin'

    # --- Games ---
    'itch'
    'polymc'
)

cd ${HOME}/yay
makepkg -si

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo "###########"
echo "## DONE! ##"
echo "###########"