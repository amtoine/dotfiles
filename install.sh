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


BASE_DEPENDENCIES=(
    archlinux-keyring
    base-devel
    git
    vim
    nushell
    cargo
)

RAW_DOTFILES="https://raw.githubusercontent.com/goatfiles/dotfiles"
REVISION="main"

LOCAL_PKGS_FILE="/tmp/pkgs.toml"

REMOTE_DMENU="https://github.com/bakkeby/dmenu-flexipatch"
LOCAL_DMENU_DIR="/tmp/dmenu"

REMOTE_PKGBUILDS="https://github.com/goatfiles/pkgbuilds"
LOCAL_PKGBUILDS_DIR="/tmp/pkgbuilds"

PKGBUILDS=(
    paru
    amtoine-scripts-git
    amtoine-sounds-git
    amtoine-wallpapers-git
    amtoine-applications-git
    amtoine-icons-git
    junnunkarim-wallpapers-git
    mut-ex-wallpapers-git
)

SYSTEM_SERVICES=(
    sddm
    NetworkManager
    cronie
    bluetooth
)

REMOTE_DOTFILES="https://github.com/goatfiles/dotfiles"
LOCAL_DOTFILES_DIR="$HOME/.local/share/ghq/github.com/goatfiles/dotfiles"


install_base () {
    sudo pacman --noconfirm -Syyu "${BASE_DEPENDENCIES[@]}"
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
    [ -d "$LOCAL_PKGBUILDS_DIR" ] && sudo rm -r "$LOCAL_PKGBUILDS_DIR"
    git clone "$REMOTE_PKGBUILDS" "$LOCAL_PKGBUILDS_DIR"

    # Build pkgbuilds
    (
        cd "$LOCAL_PKGBUILDS_DIR"
        for pkgbuild in "${PKGBUILDS[@]}"; do
            ./cleanup.sh
            ./install.sh "x86_64/$pkgbuild/PKGBUILD"
        done
        ./cleanup.sh
    )
}


install_dependencies () {
    pacman_deps=$(nu -c "\
        open $LOCAL_PKGS_FILE \
        | get pkgs.pacman.explicit.package \
        | find --invert --regex 'amtoine|wallpapers'\
    ")
    rust_deps=$(nu -c "\
        open $LOCAL_PKGS_FILE \
        | get pkgs.rust.cargo.package \
    ")
    python_deps=$(nu -c "\
        open $LOCAL_PKGS_FILE \
        | get pkgs.python.pip.package \
    ")

    paru -S $pacman_deps
    cargo install $rust_deps
    pip install $python_deps
}


install_dmenu () {
    git clone "$REMOTE_DMENU" "$LOCAL_DMENU_DIR"
    (
        cd "$LOCAL_DMENU_DIR"
        sudo make clean install
    )
}


activate_system () {
    for service in "${SYSTEM_SERVICES[@]}"; do
        sudo systemctl enable "$service"
    done
}


pull_dotfiles () {
    git clone --bare "$REMOTE_DOTFILES" "$LOCAL_DOTFILES_DIR"
    cfg="/usr/bin/git --git-dir=$LOCAL_DOTFILES_DIR --work-tree=$HOME"
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

