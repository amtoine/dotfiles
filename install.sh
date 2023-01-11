#!/usr/bin/bash
#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

# Update
sudo pacman -S archlinux-keyring
sudo pacman -Syu

# Install tools for building dependencies
sudo pacman -S git nushell cargo feh

# Clone dotfiles
git clone --bare https://github.com/goatfiles/dotfiles $HOME/.dotfiles
cfg="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
$cfg reset --hard
$cfg config --local status.showUntrackedFiles no
$cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Clean and clone pkgbuilds
if [[ -d /tmp/pkgbuilds ]]; then sudo rm -r /tmp/pkgbuilds; fi
git clone https://github.com/goatfiles/pkgbuilds /tmp/pkgbuilds

# Build pkgbuilds
(
    cd /tmp/pkgbuilds
    ./install.sh x86_64/goat-paru-git/
    ./install.sh x86_64/goat-scripts-git/
    ./install.sh x86_64/goat-sounds-git/
    ./install.sh x86_64/goat-wallpapers-git/
    ./install.sh x86_64/goat-applications-git/
    ./install.sh x86_64/goat-icons-git/
    ./install.sh x86_64/goat-junnunkarim-wallpapers-git/
    ./install.sh x86_64/goat-mut-ex-wallpapers-git/
)

# Install dependencies
nu -c 'paru -S (open $"($env.HOME)/pkgs.toml" | get pkgs.pacman.explicit.package | find --invert --regex "amtoine|wallpapers")'

# Install dmenu-flexipatch
git clone https://github.com/bakkeby/dmenu-flexipatch /tmp/dmenu
cp $HOME/.config/dmenu-flexipatch/patches.h /tmp/dmenu
(
    cd /tmp/dmenu
    sudo make clean install
)

# Activate useful system
sudo systemctl enable sddm
sudo systemctl enable NetworkManager

# Greet
echo 'Installation completed! Please reboot your computer.'

