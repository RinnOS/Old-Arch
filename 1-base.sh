#!/usr/bin/env bash

echo "##############################"
echo "## INSTALLING BASE PACKAGES ##"
echo "##############################"
echo

PKGS=(

    # --- Audio ---
    'pulseaudio'
    'pulseaudio-alsa'
    'pulseaudio-bluetooth'
    'pulseaudio-jack'
    'ffmpeg'

    # --- Bluetooth ---
    'bluez'
    'bluez-utils'
    'blueman'

    # --- Terminal ---
    'zsh'
    'zsh-autosuggestions'
    'zsh-syntax-highlighting'
    'xclip'
    'bat'
    'thefuck'
    'btop'
    'curl'
    'wget'

    # --- Docker ---
    'docker'
    'docker-compose'

    # --- Fonts ---
    'noto-fonts'
    'noto-fonts-emoji'
    'ttf-font-awesome'
    'ttf-fira-code'

    # --- Uncategorized | Related to Wine hell ---
    'nvidia-utils'
    'nvidia-dkms'
    'lib32-nvidia-utils'
    'nvidia-settings'
    'vulkan-icd-loader'
    'lib32-vulkan-icd-loader'
    'wine-staging'
    'giflib'
    'lib32-giflib'
    'libpng'
    'lib32-libpng'
    'libldap'
    'lib32-libldap'
    'gnutls'
    'lib32-gnutls'
    'mpg123'
    'lib32-mpg123'
    'openal'
    'lib32-openal'
    'v4l-utils'
    'lib32-v4l-utils'
    'libpulse'
    'lib32-libpulse'
    'libgpg-error'
    'lib32-libgpg-error'
    'alsa-plugins'
    'lib32-alsa-plugins'
    'alsa-lib'
    'lib32-alsa-lib'
    'libjpeg-turbo'
    'lib32-libjpeg-turbo'
    'sqlite'
    'lib32-sqlite'
    'libxcomposite'
    'lib32-libxcomposite'
    'libxinerama'
    'lib32-libgcrypt'
    'libgcrypt'
    'lib32-libxinerama'
    'ncurses'
    'lib32-ncurses'
    'opencl-icd-loader'
    'lib32-opencl-icd-loader'
    'libxslt'
    'lib32-libxslt'
    'libva'
    'lib32-libva'
    'gtk3'
    'lib32-gtk3'
    'gst-plugins-base-libs'
    'lib32-gst-plugins-base-libs'
    'vulkan-icd-loader'
    'lib32-vulkan-icd-loader'
    'jdk8-openjdk'
)

sudo pacman -Sy
for PKG in "${PKGS[@]}"; do
    echo "Installing ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo "Mounting drives"
sh ./dotfiles/.config/mountDrives.sh

echo "###########"
echo "## DONE! ##"
echo "###########"