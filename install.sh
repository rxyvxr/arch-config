#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Updating System
pacman -Syu

# Installing an aur helper
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
# Making .config and Moving dotfiles and Background to .config
mkdir ~/.config
chown $(whoami): ~/.config
mv ./dotconfig/* ~/.config
mv ./bg.jpg ~/.config

# Installing Essential Programs 
pacman -S sddm bspwm sxhkd kitty rofi polybar picom thunar nitrogen
yay -S lxpolkit
# Installing Other less important Programs
pacman -S gimp vim lxappearance
# Installing Custom ocs-url package
#dnf install ./rpm-packages/ocs-url-3.1.0-1.fc20.x86_64.rpm

# Installing fonts
pacman -S ttf-font-awesome
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts
# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip

# Enabling Services and Graphical User Interface
systemctl enable sddm
systemctl set-default graphical.target
