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

echo "--------------"
echo "-- Vim-plug --"
echo "--------------"
echo

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "---------------------------"
echo "-- Dealing with dotfiles --"
echo "---------------------------"
echo

cd $HOME

echo "Getting wallpapers..."
git clone $(yq .links.wallpapers RinnOS/config.yaml)

echo "Getting dotfiles..."
chezmoi init --apply $(yq .links.dotfiles RinnOS/config.yaml)

cd $HOME/RinnOS

sh $HOME/scripts/mountDrives.sh
I=0
while [ ! $I -eq $(yq '.local | length' dotfiles.yaml) ]; do
    localdotfile=$(yq -r .local[$I] dotfiles.yaml)
    LOCALDOTDIR=$(yq -r .paths.localdotdir config.yaml)

    rm -rf "${HOME}/${localdotfile}"
    echo
    echo "Copying ${LOCALDOTDIR}/${localdotfile} to ${HOME}/${localdotfile}"
    cp -faT "${LOCALDOTDIR}/${localdotfile}" "${HOME}/${localdotfile}"
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

echo "--------------------------"
echo "-- Global Node packages --"
echo "--------------------------"

sudo npm install -g n

echo "-------------------------"
echo "-- Some extra stuff... --"
echo "-------------------------"
echo

echo "Installing language servers..."
sh $HOME/RinnOS/10-language-servers.sh

echo
echo "Setting RTC to local time"
sudo timedatectl set-local-rtc 1

echo
echo "Copying optimus-manager config..."
sudo cp ./files/optimus-manager.conf /etc/optimus-manager/optimus-manager.conf

echo
echo "Changing default shell to zsh"
chsh -s $(which zsh)

echo
echo "Syncing Doom emacs"
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
cd $HOME/.emacs.d/bin
sh doom sync

echo
echo "Adding user to docker group"
sudo usermod -aG docker $USER

echo
echo "Changing perms for ssh"
cd $HOME/.ssh
chmod 600 id_25519
chmod 600 id_25519_sk
chmod 600 config
chmod 600 gitlab

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
