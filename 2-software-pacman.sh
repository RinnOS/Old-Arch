#!/usr/bin/env bash

echo "##################################"
echo "## INSTALLING SOFTWARE PACKAGES ##"
echo "##################################"
echo

PKGS=(
    # --- Terminal ---
    'vim'
    'wget'
    'calc'
    'neofetch'

    # --- Games ---
    'steam'
    'gamemode'
    'lib32-gamemode'
    'lutris'

    # --- Development ---
    'nodejs'
    'npm'
    'yarn'
    'git'

    # --- Virtualization ---
    'virtualbox'
    'virtualbox-host-dkms'
    'virt-manager'
    'virt-viewer'

    # --- Audio/Video ---
    'vlc'
    'mpv'
    'feh'

    # --- Security ---
    'firetools'

    # --- Applications ---
    'emacs'
    'signal-desktop'
    'discord'
    'terminator'
    'gimp'
    'qbittorrent'

    # --- Office ---
    'libreoffice'

    # --- Dependencies ---
    'ripgrep'
    'fd'
    'coreutils'

    # --- Utilities ---
    'imwheel'
    'flameshot'
    'grub-customizer'
    'numlockx'

    # --- Uncategorized ---
    'aspell'
    'aspell-en'
    'aspell-sv'
    'mono'
    'perl-anyevent-i3'
)

sudo pacman -Sy
for PKG in "${PKGS[@]}"; do
    echo "Installing ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo "###########"
echo "## DONE! ##"
echo "###########"