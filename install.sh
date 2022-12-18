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

install_base () {
    sudo pacman --noconfirm -Syyu archlinux-keyring base-devel git vim nushell cargo
}


synchronize_database () {
    sudo pacman -Fy
}


pull_files () {
    curl -fLo /tmp/pkgs.toml https://raw.githubusercontent.com/goatfiles/dotfiles/main/pkgs.toml
    curl -fLo /tmp/dmenu/patches.h https://raw.githubusercontent.com/goatfiles/dotfiles/main/.config/dmenu-flexipatch/patches.h
}


install_pkgbuilds () {
    # Clean and clone pkgbuilds
    [ -d /tmp/pkgbuilds ] && sudo rm -r /tmp/pkgbuilds
    git clone https://github.com/goatfiles/pkgbuilds /tmp/pkgbuilds

    # Build pkgbuilds
    (
        cd /tmp/pkgbuilds
        ./install.sh x86_64/paru
        ./clean.sh
        ./install.sh x86_64/amtoine-scripts-git/
        ./clean.sh
        ./install.sh x86_64/amtoine-sounds-git/
        ./clean.sh
        ./install.sh x86_64/amtoine-wallpapers-git/
        ./clean.sh
        ./install.sh x86_64/amtoine-applications-git/
        ./clean.sh
        ./install.sh x86_64/amtoine-icons-git/
        ./clean.sh
        ./install.sh x86_64/junnunkarim-wallpapers-git
        ./clean.sh
        ./install.sh x86_64/mut-ex-wallpapers-git
    )
}


install_base
synchronize_database

pull_files

install_pkgbuilds

# Install dependencies
nu -c 'paru -S (open /tmp/pkgs.toml | get pkgs.pacman.explicit.package | find --invert --regex "amtoine|wallpapers")'

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

# Clone dotfiles
git clone --bare https://github.com/goatfiles/dotfiles $HOME/.local/share/ghq/github.com/goatfiles/dotfiles
cfg="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
$cfg reset --hard
$cfg config --local status.showUntrackedFiles no
$cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
$cfg fetch

# Greet
echo 'Installation completed! Please reboot your computer.'

