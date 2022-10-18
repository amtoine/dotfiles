#!/usr/bin/bash

# Update
sudo pacman -S archlinux-keyring
sudo pacman -Syu

# Install tools for building dependencies
sudo pacman -S git nushell cargo feh

# Clone dotfiles
git clone --bare https://github.com/goatfiles/dotfiles .dotfiles
git clone https://github.com/goatfiles/pkgbuilds /tmp/pkgbuilds
cfg="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
$cfg reset --hard
$cfg config --local status.showUntrackedFiles no
$cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Build pkgbuilds
(
    cd /tmp/pkgbuilds
    ./install.sh x86_64/paru
    ./install.sh x86_64/amtoine-scripts-git/
    ./install.sh x86_64/amtoine-sounds-git/
    ./install.sh x86_64/amtoine-wallpapers-git/
    ./install.sh x86_64/amtoine-applications-git/
    ./install.sh x86_64/amtoine-icons-git/
    ./install.sh x86_64/junnunkarim-wallpapers-git
    ./install.sh x86_64/mut-ex-wallpapers-git
)

# Install dependencies
nu -c 'paru -S (open pkgs.toml | get pkgs.pacman.explicit.package | find --invert --regex "amtoine|wallpapers")'

# Install dmenu-flexipatch
(
    git clone https://github.com/bakkeby/dmenu-flexipatch /tmp/dmenu
    cp .config/dmenu-flexipatch/patches.h /tmp/dmenu
    cd /tmp/dmenu
    sudo make clean install
)

# Activate useful system
sudo systemctl enable sddm
sudo systemctl enable NetworkManager

# Greet
echo 'Installation completed! Please reboot your computer.'

