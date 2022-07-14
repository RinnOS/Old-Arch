#!/usr/bin/env bash

echo "##################"
echo "## FINAL SETUPS ##"
echo "##################"
echo

echo "-----------------------"
echo "-- Starting Services --"
echo "-----------------------"
echo

sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

echo "---------------"
echo "-- ZSH Setup --"
echo "---------------"
echo

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "---------------------------"
echo "-- Dealing with dotfiles --"
echo "---------------------------"
echo

cd $HOME

echo "Getting wallpapers..."
git clone $(yq .links.wallpapers RinnOS/config.yaml)

echo "Getting dotfiles..."
chezmoi init --apply $(yq .links.dotfiles RinnOS/config.yaml)

# I=0
# while [ $I -le $(yq '.git | length' dotfiles.yaml) ]; do
#     dotfile=$(yq .git[$I] dotfiles.yaml)
#     DOTDIR=$(yq .paths.dotdir config.yaml)

#     if [ -z "$dotfile" ]; then
#         break
#     fi

#     rm -rf "${HOME}/$dotfile"
#     echo
#     echo "Linking ${DOTDIR}/${dotfile} to ${HOME}/${dotfile}"
#     cp -faTs "${DOTDIR}/${dotfile}" "${HOME}/${dotfile}"
#     ((I++))
# done
cd $HOME/RinnOS

sh ./dotfiles/scripts/mountDrives.sh
I=0
while [ ! $I -eq $(yq '.local | length' dotfiles.yaml) ]; do
    localdotfile=$(yq .local[$I] dotfiles.yaml)
    LOCALDOTDIR=$(yq .paths.localdotdir config.yaml)

    rm -rf "${HOME}/${localdotfile}"
    echo
    echo "Linking ${LOCALDOTDIR}/${localdotfile} to ${HOME}/${localdotfile}"
    cp -faTs "${LOCALDOTDIR}/${localdotfile}" "${HOME}/${localdotfile}"
    ((I++))
done

echo "-------------------"
echo "-- Virtulazation --"
echo "-------------------"
echo

# Check if libvirtd group exists and create it if not
if ! getent group libvirtd > /dev/null; then
    echo "Creating libvirtd group"
    sudo groupadd libvirtd
fi

sudo usermod -G libvirtd -a "${USER}"

echo "--------------------------------"
echo "-- Setting up optimus-manager --"
echo "--------------------------------"

echo "Copying optimus-manager config..."
sudo cp ./files/optimus-manager.conf /etc/optimus-manager/optimus-manager.conf

echo "-------------------------"
echo "-- Some extra stuff... --"
echo "-------------------------"
echo

echo "Setting RTC to local time"
sudo timedatectl set-local-rtc 1

echo
echo "Changing default shell to zsh"
chsh -s $(which zsh)

echo
echo "Syncing Doom emacs"
cd $HOME/.emacs.d/bin
sh doom sync

echo "###########"
echo "## DONE! ##"
echo "###########"
echo

echo "Do you want to reboot? (y/n)"
read reboot
if [ "$reboot" == "y" ]; then
    echo "Rebooting..."
    sudo reboot
fi