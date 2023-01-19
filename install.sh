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
    sddm
    bspwm
    sxhkd
    alacritty
    cronie
    blueman
    bluez
    bluez-utils
    bluez-libs
    bluez-plugins
)

RAW_GOATFILES="https://raw.githubusercontent.com/goatfiles"
REVISION="main"

LOCAL_PKGS_FILE="/tmp/pkgs.toml"

REMOTE_DMENU="https://github.com/bakkeby/dmenu-flexipatch"
LOCAL_DMENU_DIR="/tmp/dmenu"

REMOTE_PKGBUILDS="https://github.com/goatfiles/pkgbuilds"
LOCAL_PKGBUILDS_DIR="/tmp/pkgbuilds"

PKGBUILDS=(
    goat-paru-git
    goat-scripts-git
    goat-sounds-git
    goat-wallpapers-git
    goat-applications-git
    goat-icons-git
    goat-junnunkarim-wallpapers-git
    goat-mut-ex-wallpapers-git
)

SYSTEM_FILES=(
    etc/pacman.conf
    etc/pacman.d/mirrorlist
    etc/sddm.conf
    usr/share/sddm/themes/sugar-candy/theme.conf
    var/spool/cron/user
)

SYSTEM_SERVICES=(
    sddm
    NetworkManager
    cronie
    bluetooth
)

REMOTE_DOTFILES="https://github.com/goatfiles/dotfiles"
LOCAL_DOTFILES_DIR="$HOME/.local/share/ghq/github.com/goatfiles/dotfiles"


echo_and_run () {
    echo -e "\e[93m== running following command ==================\e[0m"
    echo -e "\e[93m$@\e[0m"

    eval "$@" || {
        echo -e "\e[91m== an error occured... terminating... =========\e[0m"
        echo -e "\e[91m'$@' failed...\e[0m"
        echo -e "\e[91mcurrent pwd: $(pwd)\e[0m"
        exit 1
    }
}


install_base () {
    echo_and_run sudo pacman --noconfirm -Syyu "${BASE_DEPENDENCIES[@]}"
}


synchronize_database () {
    echo_and_run sudo pacman -Fy
}


install_pkgbuilds () {
    # Clean and clone pkgbuilds
    [ -d "$LOCAL_PKGBUILDS_DIR" ] && echo_and_run sudo rm -r "$LOCAL_PKGBUILDS_DIR"
    echo_and_run git clone "$REMOTE_PKGBUILDS" "$LOCAL_PKGBUILDS_DIR"

    # Build pkgbuilds
    (
        echo_and_run cd "$LOCAL_PKGBUILDS_DIR"
        for pkgbuild in "${PKGBUILDS[@]}"; do
            echo_and_run ./cleanup.sh
            yes | echo_and_run ./install.sh "x86_64/$pkgbuild/PKGBUILD" || exit 1
        done
        echo_and_run ./cleanup.sh
    )
    [ "$?" -ne 0 ] && exit 1
}


install_dependencies () {
    echo_and_run curl -fLo "$LOCAL_PKGS_FILE" "$RAW_GOATFILES/dotfiles/$REVISION/pkgs.toml"

    pacman_deps=$(nu -c "\
        open $LOCAL_PKGS_FILE \
        | get pkgs.pacman.explicit.package \
        | find --invert --regex 'goat-.*-git'\
    ")
    rust_deps=$(nu -c "\
        open $LOCAL_PKGS_FILE \
        | get pkgs.rust.cargo.package \
    ")
    python_deps=$(nu -c "\
        open $LOCAL_PKGS_FILE \
        | get pkgs.python.pip.package \
    ")

    echo_and_run paru -S $pacman_deps
    echo_and_run cargo install $rust_deps
    echo_and_run pip install $python_deps
}


install_dmenu () {
    [ -d "$LOCAL_DMENU_DIR" ] && echo_and_run sudo rm -r "$LOCAL_DMENU_DIR"
    echo_and_run git clone "$REMOTE_DMENU" "$LOCAL_DMENU_DIR"

    echo_and_run curl -fLo "$LOCAL_DMENU_DIR/patches.h" "$RAW_GOATFILES/dotfiles/$REVISION/.config/dmenu-flexipatch/patches.h"

    (
        echo_and_run cd "$LOCAL_DMENU_DIR"
        yes | echo_and_run sudo make clean install || exit 1
    )
    [ "$?" -ne 0 ] && exit 1
}


install_system_files () {
    for file in "${SYSTEM_FILES[@]}"; do
        echo_and_run sudo mkdir -p "/$(dirname "$file")"
        echo_and_run sudo curl -fLo "/$file" "$RAW_GOATFILES/system/$REVISION/$file"
    done
}


activate_system () {
    for service in "${SYSTEM_SERVICES[@]}"; do
        echo_and_run sudo systemctl enable "$service"
    done
}


pull_dotfiles () {
    echo_and_run git clone --bare "$REMOTE_DOTFILES" "$LOCAL_DOTFILES_DIR"
    cfg="/usr/bin/git --git-dir=$LOCAL_DOTFILES_DIR --work-tree=$HOME"
    echo_and_run $cfg reset --hard
    echo_and_run $cfg config --local status.showUntrackedFiles no
    echo_and_run $cfg config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    echo_and_run $cfg fetch
    echo_and_run $cfg checkout "$REVISION"
}


install_base
synchronize_database

install_pkgbuilds
#install_dependencies
install_dmenu

install_system_files
activate_system

pull_dotfiles

echo -e "\e[92mInstallation completed! Please reboot your computer\e[0m."

