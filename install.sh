#!/bin/bash

# Exit on error
set -e

# Update system before running script
read -p "Would you like to update your system before running this script(recommended) [Y/n]: " update_confirm
update_confirm=${update_confirm:-Y}
    echo "Skipping system update"
else
    echo "Updating system"
    sudo pacman -Syu
fi

# Dependancies
echo "Installing dependencies..."
sudo pacman -S --needed git base-devel

if ! command -v paru & > /dev/null; then
    echo "paru AUR helper not found, installing..."
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
else
    echo "paru is already installed"
fi

# List of packages to install
PACKAGES=("wallust" foot" "btop" "fish" "swww" "quickshell" "firefox" "neofetch" "cava" "cmatrix" "ttf-jetbrains-mono)

paru -S --noconfirm "${PACKAGES[@]}


echo "Script finished succesfully"