#! /usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#             __  _         _        _ _      _
#      ___   / / (_)_ _  __| |_ __ _| | |  __| |_
#     (_-<  / /  | | ' \(_-<  _/ _` | | |_(_-< ' \
#     /__/ /_/   |_|_||_/__/\__\__,_|_|_(_)__/_||_|
#
# Description:  this is the deployment script of my dotfiles.
#               assumes basic Arch Linux installation: https://www.youtube.com/watch?v=PQgyW10xD8s
#               commands taken from: https://www.youtube.com/watch?v=pouX5VvX0_Q
# Dependencies: pacman, curl
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

DOTFILES="$HOME/.dotfiles.a2n-s"
CHANNEL="main"
DRC="/tmp/.install.dialogrc"
curl -fLo "$DRC" https://raw.githubusercontent.com/a2n-s/dotfiles/refacto/scripts/.install.dialogrc

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
MAGENTA="$(tput setaf 5)"
RES="$(tput sgr0)"

error() {
  echo -e "${RED}ERROR:\n$1${RES}"; exit 1;
}

warning () {
  echo -e "${YELLOW}$1${RES}"
}

info () {
  echo -e "${MAGENTA}$1${RES}"
}

root_warning () {
  warning "##################################################################"
  warning "This script MUST NOT be run as root user since it makes changes"
  warning "to the \$HOME directory of the \$USER executing this script."
  warning "The \$HOME directory of the root user is, of course, '/root'."
  warning "We don't want to mess around in there. So run this script as a"
  warning "normal user. You will be asked for a sudo password when necessary."
  warning "##################################################################"
  exit 1
}

welcome() {
  DIALOGRC="$DRC" dialog --colors --title "\Z7\ZbInstalling a2n-s' config!" --msgbox "\Z4This is a script that will install my current main config. It's really just an installation script for those that want to try out my Qtile desktop.  We will add install the Qtile tiling window manager, the kitty and alacritty terminal emulators , the Fish shell with Oh My Fish and augment the bash shell with Oh My Bash, Doom Emacs and my rice of Neovim and many other essential programs needed to make my dotfiles work correctly.\\n\\n-a2n-s (Antoine Stevan)" 16 60
  DIALOGRC="$DRC" dialog --colors --title "\Z7\ZbStay near your computer!" --yes-label "Continue" --no-label "Exit" --yesno "\Z4This script is not allowed to be run as root, but you will be asked to enter your sudo password at various points during this installation. This is to give PACMAN the necessary permissions to install the software.  So stay near the computer." 8 60
}

lastchance() {
  DIALOGRC="$DRC" dialog --colors --title "\Z7\ZbInstalling a2n-s' config!" --msgbox "\Z4WARNING! This installation script is currently in public beta testing. There are almost certainly errors in it; therefore, it is strongly recommended that you not install this on production machines. It is recommended that you try this out in either a virtual machine or on a test machine." 16 60
  DIALOGRC="$DRC" dialog --colors --title "\Z7\ZbAre You Sure You Want To Do This?" --yes-label "Begin Installation" --no-label "Exit" --yesno "\Z4Shall we begin installing a2n-s' config?" 8 60 || { clear; exit 1; }
}

sync_repos () {
  info "################################################################"
  info "## Syncing the repos and installing 'dialog' if not installed ##"
  info "################################################################"
  sudo pacman --noconfirm --needed -Syu dialog
}

init_deps () {
  deps_file=$(mktemp /tmp/a2n-s_dotfiles_deps.XXXXXX)
  trap 'rm "$deps_file"' 0 1 15
}

_confirm_driver () {
  DIALOGRC="$DRC" dialog --colors \
    --title "Selected driver: '$1'" \
    --no-label "Select this driver" \
    --yes-label "Change the driver" \
    --yesno "" 5 60 3>&2 2>&1 1>&3
  if [ "$?" == 0 ]; then
    echo "no driver"
  else
    echo "$1"
  fi
}
select_driver () {
  local driver="no driver"
  while [ "$driver" = "no driver" ]
  do
    driver=$(DIALOGRC="$DRC" dialog --colors --clear \
      --title "Mandatory drivers" \
      --menu "Choose a video driver (** ~ proprietary)" 16 48 16 \
      1 "xf86-video-fbdev (VM)" \
      2 "xf86-video-amdgpu (AMD/ATI)" \
      3 "xf86-video-ati (AMD/ATI)" \
      4 "xf86-video-amdgpu (AMD/ATI**)" \
      5 "xf86-video-intel1 (Intel)" \
      6 "xf86-video-nouveau (NVIDIA)" \
      7 "nvidia (NVIDIA**)" \
      8 "nvidia-470xx-dkms (NVIDIA**) (AUR)" \
      9 "nvidia-390xx (NVIDIA**) (AUR)" 3>&2 2>&1 1>&3 \
    )
    case "$driver" in
      1) driver=$(_confirm_driver "xf86-video-fbdev") ;;
      2) driver=$(_confirm_driver "xf86-video-amdgpu") ;;
      3) driver=$(_confirm_driver "xf86-video-ati") ;;
      4) driver=$(_confirm_driver "xf86-video-amdgpu") ;;
      5) driver=$(_confirm_driver "xf86-video-intel1") ;;
      6) driver=$(_confirm_driver "xf86-video-nouveau") ;;
      7) driver=$(_confirm_driver "nvidia") ;;
      8) driver=$(_confirm_driver "nvidia-470xx-dkms") ;;
      9) driver=$(_confirm_driver "nvidia-390xx") ;;
      *) error "no video driver selected";;
    esac
  done
  echo "pacman:$driver" >> "$deps_file"
}

_confirm_boot () {
  local msg=""
  if [ "$1" = "" ];
  then
    msg="You have selected no boot option\nNo grub theme, no tty login prompt nor login manager will be installed"
  else
    msg=$(echo "$1" | tr ' ' '\n')
  fi
  DIALOGRC="$DRC" dialog --colors \
    --title "Selected boot options:" \
    --no-label "Select" \
    --yes-label "Change the boot options" \
    --yesno "$msg" 7 60 3>&2 2>&1 1>&3
  if [ "$?" == 0 ]; then
    echo "1"
  else
    echo "0"
  fi
}
select_boot () {
  local boot=""
  local loop=1
  while [ "$loop" = 1 ]
  do
    boot=$(DIALOGRC="$DRC" dialog --colors --clear \
      --title "Boot time" \
      --checklist "Choose" 10 48 16 \
      grub "" on \
      sddm "" on \
      issue "" on 3>&2 2>&1 1>&3 \
    )
    [ ! "$?" = 0 ] && return 1
    loop=$(_confirm_boot "$boot")
  done
  echo "$boot" | tr ' ' '\n' >> "$deps_file"
}

_confirm_wm () {
  local msg=""
  if [ "$1" = "" ];
  then
    msg="You have selected no window manager\n\nAre You Sure You Really Want To Do That?"
  else
    msg=$(echo "$1" | tr ' ' '\n')
  fi
  DIALOGRC="$DRC" dialog --colors \
    --title "Selected window managers:" \
    --no-label "Select" \
    --yes-label "Change" \
    --yesno "$msg" 7 60 3>&2 2>&1 1>&3
  if [ "$?" == 0 ]; then
    echo "1"
  else
    echo "0"
  fi
}
select_wm () {
  local wms=""
  local loop=1
  while [ "$loop" = 1 ]
  do
    wms=$(DIALOGRC="$DRC" dialog --colors --clear \
      --title "Window managers:" \
      --checklist "Choose" 10 48 16 \
      qtile "" on \
      bspwm "" off \
      spectrwm "" off 3>&2 2>&1 1>&3 \
    )
    [ ! "$?" = 0 ] && return 1
    loop=$(_confirm_wm "$wms")
  done
  echo "$wms" | tr ' ' '\n' >> "$deps_file"
}

build_deps () {
  info "################################################################"
  info "## Building the dependency table of the whole configuration   ##"
  info "################################################################"
  declare -A deps_table
  deps_table[base_deps]="pacman:base-devel pacman:python pacman:python-pip pacman:xorg pacman:xorg-xinit yay-git:yay"
  deps_table[deps]="*pacman:qtile pacman:firefox pacman:neovim"
  deps_table[opt_deps]="make:dmenu make:tabbed *make:surf make:slock"

  deps_table[qtile_deps]="pacman:qtile pacman:python-gobject pacman:gtk3 pip:gdk yay:nerd-fonts-mononoki pip:psutil pip:dbus-next pacman:python-iwlib pacman:sddm pacman:dunst pacman:picom *pacman:feh *pacman:kitty *pacman:alacritty"
  deps_table[bspwm_deps]="pacman:bspwm pacman:sxhkd yay:nerd-fonts-mononoki pacman:sddm pacman:dunst pacman:picom *pacman:feh *pacman:kitty *pacman:alacritty"
  deps_table[spectrwm_deps]="pacman:spectrwm yay:nerd-fonts-mononoki pacman:sddm pacman:dunst pacman:picom *pacman:feh *pacman:kitty *pacman:alacritty"

  deps_table[feh_deps]="pacman:feh wallpapers:a2n-s/wallpapers"
  deps_table[kitty_deps]="pacman:kitty *pacman:fish *pacman:bash"
  deps_table[alacritty_deps]="pacman:alacritty *pacman:fish *pacman:bash"

  deps_table[bash_deps]="pacman:bash pip:virtualenvwrapper"
  deps_table[fish_deps]="pacman:fish pacman:peco yay:ghq pip:virtualfish"

  deps_table[discord_deps]="pacman:discord yay:noto-fonts-emoji"
  deps_table[surf_deps]="pacman:gcr pacman:webkit2gtk"

  info "## Expanding the dependencies                                 ##"
  echo "${deps_table[base_deps]}" | tr ' ' '\n' >> "$deps_file"
  echo "${deps_table[deps]}" | tr ' ' '\n' >> "$deps_file"
  echo "${deps_table[opt_deps]}" | tr ' ' '\n' >> "$deps_file"

  while (grep -e "^\*" "$deps_file" -q);
  do
    for dep in $(grep -e "^\*" "$deps_file"); do
      sed -i "s/$dep//g" "$deps_file"
      echo "${deps_table[$(echo "$dep" | sed 's/.*://')_deps]}" | tr ' ' '\n' >> "$deps_file"
    done
  done

  sed -ir '/^\s*$/d' "$deps_file"
  sort -o "$deps_file" "$deps_file"
}

_install_pacman_deps () {
  info "################################################################"
  info "## Installing pacman dependencies                             ##"
  info "################################################################"
  sudo pacman --needed --ask 4 -Sy $(grep -e "^pacman:" "$deps_file" | sed 's/^pacman://g' | tr '\n' ' ')
}

_install_yay () {
  info "################################################################"
  info "## Installing the yay Arch User Repositories package manager  ##"
  info "################################################################"
  git clone https://aur.archlinux.org/yay-git.git /tmp/aur.yay-git
  cd /tmp/aur.yay-git
  makepkg -si
  cd -
}

_install_yay_deps () {
  info "################################################################"
  info "## Installing yay dependencies                                ##"
  info "################################################################"
  yay --needed --ask 4 -Sy $(grep -e "^yay:" "$deps_file" | sed 's/^yay://g' | tr '\n' ' ')
}

_install_python_deps () {
  info "################################################################"
  info "## Installing python dependencies                             ##"
  info "################################################################"
  pip install $(grep -e "^pip:" "$deps_file" | sed 's/^pip://g' | tr '\n' ' ')
}

_install_custom_builds () {
  info "################################################################"
  info "## Installing custom builds of suckless-like software         ##"
  info "################################################################"
  for dep in $(grep -e "^make:" "$deps_file"); do
    name="$(echo "$dep" | sed 's/^make://g')"
    git clone "https://github.com/a2n-s/$name" "/tmp/$name"; cd "/tmp/$name"; sudo make clean install; cd -
  done
}

install_deps () {
  if grep -e "^pacman:" "$deps_file" -q; then _install_pacman_deps; fi
  _install_yay
  if grep -e "^yay:" "$deps_file" -q; then _install_yay_deps; fi
  if grep -e "^pip:" "$deps_file" -q; then _install_python_deps; fi
  if grep -e "^make:" "$deps_file" -q; then _install_custom_builds; fi
}

install_config () {
  info "###################################"
  info "## Install a new grub theme.     ##"
  info "###################################"
  git clone -b "$CHANNEL" https://github.com/a2n-s/dotfiles "$DOTFILES"
  git clone https://github.com/catppuccin/grub.git /tmp/catppuccin-grub
  sudo cp -r /tmp/catppuccin-grub/catppuccin-grub-theme /usr/share/grub/themes/
  sudo cp "$DOTFILES/.config/etc/default/grub" /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo cp "$DOTFILES/.config/etc/issue" /etc/issue
  info "###################################"
  info "## Enable sddm as login manager. ##"
  info "###################################"
  tar -xzvf "$DOTFILES/.config/etc/sddm-catppuccin.tar.gz"
  sudo mv sddm-catppuccin /usr/share/sddm/themes/catppuccin
  sudo cp "$DOTFILES/.config/etc/sddm.conf" /etc/sddm.conf
  # Disable the current login manager
  sudo systemctl disable $(grep '/usr/s\?bin' /etc/systemd/system/display-manager.service | awk -F / '{print $NF}') || warning "Cannot disable current display manager."
  # Enable sddm as login manager
  sudo systemctl enable sddm
  info "###################################"
  info "## Install some basic configs.   ##"
  info "###################################"
  cp "$DOTFILES/.xinitrc" "$HOME/.xinitrc"
  cp "$DOTFILES/.bash_profile" "$HOME/.bash_profile"
  cp -r "$DOTFILES/.config/qtile" "$HOME/.config"
  cp -r "$DOTFILES/.config/dunst" "$HOME/.config"
  cp -r "$DOTFILES/.config/picom" "$HOME/.config"
  git clone https://github.com/a2n-s/wallpapers "$HOME/repos/wallpapers"
  cp -r "$DOTFILES/.config/kitty" "$HOME/.config"
  cp -r "$DOTFILES/.config/alacritty" "$HOME/.config"
  cp -r "$DOTFILES/.config/surf" "$HOME/.config"
  info "###################################"
  info "## Build & config text editors.  ##"
  info "###################################"
  git clone https://github.com/a2n-s/nvim "$HOME/.config/nvim"
  git clone --depth 1 https://github.com/hlissner/doom-emacs "$HOME/.emacs.d"
  bash -c "$HOME/.emacs.d/bin/doom install"
  cp -r "$DOTFILES/.doom.d" "$HOME/.doom.d"
  bash -c "$HOME/.emacs.d/bin/doom sync"
  bash -c "$HOME/.emacs.d/bin/doom doctor"
  info "###################################"
  info "## Configure the shells.         ##"
  info "###################################"
  curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh | bash -s -- --dry-run
  curl -fsSLo /tmp/omf.install https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install; chmod +x /tmp/omf.install; fish -c "/tmp/omf.install --noninteractive"
  fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
  cp "$DOTFILES/.bashrc" "$HOME/.bashrc"
  cp "$DOTFILES/.bash_aliases" "$HOME/.bash_aliases"
  cp -r "$DOTFILES/.config/fish" "$HOME/.config"
  cp -r "$DOTFILES/.config/omf" "$HOME/.config"
  fish -c "omf install"
  fish -c "omf update"
  fish -c "vf install"
  fish -c "fisher update"
  info "###################################"
  info "## Final miscellaneous config.   ##"
  info "###################################"
  cp "$DOTFILES/.vimrc" "$HOME/.vimrc"
  cp "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
  cp -r "$DOTFILES/.config/htop" "$HOME/.config"
  cp -r "$DOTFILES/.config/btop" "$HOME/.config"
  cp -r "$DOTFILES/.moc" "$HOME"
  cp -r "$DOTFILES/.mpv" "$HOME/.config"
  cp -r "$DOTFILES/scripts" "$HOME"
  cp -r "$DOTFILES/.config/dmscripts" "$HOME/.config"
  cp -r "$DOTFILES/.config/lf" "$HOME/.config"
  cp -r "$DOTFILES/.config/lazygit" "$HOME/.config"
  cp -r "$DOTFILES/.config/tig" "$HOME/.config"
  cp -r "$DOTFILES/.config/rofi" "$HOME/.config"
  cp -r "$DOTFILES/.config/conky" "$HOME/.config"
}

main () {
  if [ "$(id -u)" = 0 ]; then
    root_warning
  fi
  sync_repos || error "Error syncing the repos."
  welcome || error "User choose to exit."
  lastchance || error "User choose to exit."
  init_deps || error "Error creating the dependencies file"
  select_driver || error "Video driver selection failed"
  # select_boot || error "Error choosing boot options"
  # select_wm || error "Error choosing a window manager"
  build_deps
  install_deps
  install_config || error "Error installing the configuration files"

  info "####################################"
  info "## The config has been installed! ##"
  info "####################################"

  PS3="${GREEN}Set default user shell (enter number): ${RES}"
  shells=("fish" "bash" "zsh" "quit")
  select choice in "${shells[@]}"; do
      case $choice in
           fish | bash | zsh)
              sudo chsh $USER -s "/bin/$choice" && \
              echo -e "$choice has been set as your default USER shell. \
                      \nLogging out is required for this to take effect."
              break
              ;;
           quit)
              echo "User quit without changing shell."
              break
              ;;
           *)
              echo "invalid option $REPLY"
              ;;
      esac
  done

  while true; do
      read -p "${GREEN}Do you want to reboot to get your new config?${RES} [Y/n] " yn
      case $yn in
          [Yy]* ) sudo reboot;;
          [Nn]* ) break;;
          "" ) sudo reboot;;
          * ) echo "${RED}Please answer yes or no.${RES}";;
      esac
  done
}
main
exit 0

