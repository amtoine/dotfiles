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

RAW_DOTFILES="https://raw.githubusercontent.com/goatfiles/dotfiles"
REVISION="main"

LOCAL_PKGS_FILE="/tmp/pkgs.toml"

REMOTE_DMENU="https://github.com/bakkeby/dmenu-flexipatch"
LOCAL_DMENU_DIR="/tmp/dmenu"


install_base () {
    sudo pacman --noconfirm -Syyu archlinux-keyring base-devel git vim nushell cargo
}


synchronize_database () {
    sudo pacman -Fy
}

pull_files () {
    curl -fLo "$LOCAL_PKGS_FILE" "$RAW_DOTFILES/$REVISION/pkgs.toml"
    curl -fLo "$LOCAL_DMENU_DIR/patches.h" "$RAW_DOTFILES/$REVISION/.config/dmenu-flexipatch/patches.h"
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


install_dependencies () {
    nu -c "paru -S (open $LOCAL_PKGS_FILE | get pkgs.pacman.explicit.package | find --invert --regex 'amtoine|wallpapers')"
}


install_dmenu () {
    git clone "$REMOTE_DMENU" "$LOCAL_DMENU_DIR"
    (
        cd "$LOCAL_DMENU_DIR"
        sudo make clean install
    )
}


activate_system () {
    sudo systemctl enable sddm
    sudo systemctl enable NetworkManager
    sudo systemctl enable cronie
    sudo systemctl enable bluetooth
}


pull_dotfiles () {
    git clone --bare https://github.com/goatfiles/dotfiles $HOME/.local/share/ghq/github.com/goatfiles/dotfiles
    cfg="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
    $cfg reset --hard
    $cfg config --local status.showUntrackedFiles no
    $cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    $cfg fetch
}


install_base
synchronize_database

pull_files

install_pkgbuilds
install_dependencies
install_dmenu

activate_system

pull_dotfiles

echo 'Installation completed! Please reboot your computer.'

