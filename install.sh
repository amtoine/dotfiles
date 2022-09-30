#!/usr/bin/bash

# Update
sudo pacman -S archlinux-keyring
sudo pacman -Syu

# Install tools for building dependencies
sudo pacman -S git nushell cargo feh

# Clone dotfiles
git clone --bare https://github.com/atxr/dotfiles-1 .dotfiles
git clone https://github.com/amtoine/pkgbuilds /tmp/pkgbuilds
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME reset --hard
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Build pkgbuilds
/tmp/pkgbuilds/install.sh x86_64/paru x86_64/amtoine-scripts-git/ x86_64/amtoine-sounds-git/ x86_64/amtoine-wallpapers-git/ x86_64/amtoine-applications-git/ x86_64/amtoine-icons-git/ x86_64/junnunkarim-wallpapers-git x86_64/mut-ex-wallpapers-git

# Install dependencies
nu -c 'paru -S (open pkgs.toml | get pkgs.pacman.explicit.package | find --invert --regex "amtoine|wallpapers")'

# Install dmenu-flexipatch
{
    git clone https://github.com/bakkeby/dmenu-flexipatch /tmp/dmenu
    cp .config/dmenu-flexipatch/patches.h /tmp/dmenu
    cd /tmp/dmenu
    sudo make clean install
}

# Activate useful system
sudo systemctl enable sddm
sudo systemctl enable NetworkManager

# Greet
echo 'Installation completed! Please reboot your computer.'

