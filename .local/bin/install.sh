#! /usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#        _     __  _        __  _         _        _ _      _
#       | |   / / | |__    / / (_)_ _  __| |_ __ _| | |  __| |_
#      _| |  / /  | '_ \  / /  | | ' \(_-<  _/ _` | | |_(_-< ' \
#     (_)_| /_/   |_.__/ /_/   |_|_||_/__/\__\__,_|_|_(_)__/_||_|
#
# Description:  this is the deployment script of my dotfiles.
#               assumes basic Arch Linux installation: https://www.youtube.com/watch?v=PQgyW10xD8s
#               commands taken from: https://www.youtube.com/watch?v=pouX5VvX0_Q
# Dependencies: pacman, curl
# License:      https://github.com/a2n-s/dotfiles/LICENSE
# Contributors: Stevan Antoine

# some color definitions
BLK="$(tput setaf 0)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
OFF="$(tput sgr0)"
CMD="$CYAN"
SRC="$YELLOW"
DST="$GREEN"
SUB="$WHITE"

error() {
  #
  # display the first argument as an error,
  # in red,
  # then exit the program.
  #
  # designed to be used as the piped output of another
  # process, e.g. `process || error "process failed"`
  #
  echo -e "${RED}ERROR:\n$1${OFF}"; exit 1;
}

warning () {
  #
  # display the first argument as a warning,
  # in yellow.
  #
  echo -e "${YELLOW}$1${OFF}"
}

info () {
  #
  # display the first argument as a regular info,
  # in magenta.
  #
  echo -e "${MAGENTA}$1${OFF}"
}

# some environment variable definitions and
# preliminary work to get all the material
# necessary to the deployment.
[[ ! -v DOTFILES ]] && DOTFILES="$HOME/.dotfiles.a2n-s"
[[ ! -v CHANNEL ]] && CHANNEL="main"

# download the colorscheme in a temporary file.
DRC=$(mktemp /tmp/a2n-s_dotfiles_dialogrc.XXXXXX)
trap 'rm "$DRC"' 0 1 15
_dialogrc_url="https://raw.githubusercontent.com/a2n-s/dotfiles/$CHANNEL/.local/bin/.install.dialogrc"
curl -fsSLo "$DRC" "$_dialogrc_url" || error "Error downloading $_dialogrc_url"

# declare the global dependency table.
declare -A deps_table

root_warning () {
  #
  # exit if the user runs the script as root.
  #
  warning "##################################################################"
  warning "This script MUST NOT be run as root user since it makes changes"
  warning "to the \$HOME directory of the \$USER executing this script."
  warning "The \$HOME directory of the root user is, of course, '/root'."
  warning "We don't want to mess around in there. So run this script as a"
  warning "normal user. You will be asked for a sudo password when necessary."
  warning "##################################################################"
  exit 1
}

sync_repos () {
  #
  # synchronize the local pacman database to be as up-to-date
  # as possible
  # installs the dependencies of the script.
  #
  info "############################################################"
  info "## Syncing the repos and installing script's dependencies ##"
  info "############################################################"
  sudo pacman --noconfirm --needed -Syu dialog
}

welcome() {
  #
  # launch `dialog` to present the script to the user
  # and ask to continue
  #
  # designed to be used with `error`, see `error` above
  #
  DIALOGRC="$DRC" dialog --clear --colors --title "\Z7\ZbInstalling a2n-s' config!" --msgbox "This is a script that will install my current main config. It's really just an installation script for those that want to try out my Qtile desktop.  We will add install the Qtile tiling window manager, the kitty and alacritty terminal emulators , the Fish shell with Oh My Fish and augment the bash shell with Oh My Bash, Doom Emacs and my rice of Neovim and many other essential programs needed to make my dotfiles work correctly.\\n\\n-a2n-s (Antoine Stevan)" 16 60
  DIALOGRC="$DRC" dialog --clear --colors --title "\Z7\ZbStay near your computer!" --yes-label "Continue" --no-label "Exit" --yesno "This script is not allowed to be run as root, but you will be asked to enter your sudo password at various points during this installation. This is to give PACMAN the necessary permissions to install the software.  So stay near the computer." 8 60
}

lastchance() {
  #
  # launch `dialog` again to ask a final time the
  # use if he really wants to install the config
  #
  # designed to be used with `error`, see `error` above
  #
  DIALOGRC="$DRC" dialog --clear --colors --title "\Z7\ZbInstalling a2n-s' config!" --msgbox "WARNING! This installation script is currently in public beta testing. There are almost certainly errors in it; therefore, it is strongly recommended that you not install this on production machines. It is recommended that you try this out in either a virtual machine or on a test machine." 16 60
  DIALOGRC="$DRC" dialog --clear --colors --title "\Z7\ZbAre You Sure You Want To Do This?" --yes-label "Begin Installation" --no-label "Exit" --yesno "Shall we begin installing a2n-s' config?" 8 60 || { clear; exit 1; }
}

init_deps () {
  #
  # build the dependency file which will hold the list of
  # all the software the user wants to install.
  #
  # build the dependency table that holds the dependency tree:
  #   a dependency is here of the form deps_table[cmd]="dep1 dep2"
  #   with additional options flags, e.g. `*:msg:on` or `*:msg:off`
  #   are used inside the interactive dialog, `yay:cmd` means that
  #   `cmd` is part of the AUR, etc...
  #
  deps_file=$(mktemp /tmp/a2n-s_dotfiles_deps.XXXXXX)
  trap 'rm "$deps_file"' 0 1 15

  info "################################################################"
  info "## Building the dependency table of the whole configuration   ##"
  info "################################################################"
  _commands=(  \
    "aura:AUR_helpers:off" \
    "paru::off" \

    "grub:boot:off" \
    "sddm::off" \
    "issue::off" \

    "qtile:Window_Managers:off" \
    "dwm::off" \
    "bspwm::off" \
    "spectrwm::off" \

    "st:Terminal_Emulators:off" \
    "alacritty::off" \
    "kitty::off" \

    "fish:Shells:off" \
    "bash::off" \
    "shell-color-scripts::off" \

    "emacs:Text_Editors:off" \
    "neovim::off" \
    "spacevim::off" \
    "vim::off" \

    "qutebrowser:Web_Browsers:off" \
    "surf::off" \
    "firefox::off" \
    "chromium::off" \

    "lf:File_Managers:off" \
    "sfm::off" \

    "discord:Chat_Clients:off" \
    "thunderbird::off" \
    "slack-desktop::off" \
    "signal-desktop::off" \
    "caprine::off" \

    "dunst:System:off" \
    "picom::off" \
    "pass::off" \
    "nerd-fonts-mononoki::off" \
    "wallpapers::off" \

    "lazygit:Git:off" \
    "tig::off" \

    "dmenu:App:off" \
    "dmscripts::off" \
    "rofi::off" \

    "slock:Logout:off" \
    "arcologout::off" \

    "scripts:Misc:off" \
    "devour::off" \
    "fzf::off" \
    "feh::off" \
    "htop::off" \
    "moc::off" \
    "conky::off" \
    "tabbed::off" \
    "catimg::off" \
    "btop::off" \
    "mpv::off" \
  )

  deps_table[base]="pacman:base-devel pacman:python pacman:python-pip aur-helper:yay pacman:git"
  deps_table[xorg]="pacman:xorg pacman:xorg-xinit"
  deps_table[aura]="aur-helper:aura"
  deps_table[paru]="aur-helper:paru"
  deps_table[devour]="aur:devour pacman:xdo"
  deps_table[grub]="grub aur:catppuccin-grub-theme-git aur:sekiro-grub-theme-git"
  deps_table[issue]="issue"
  deps_table[qtile]="+xorg pacman:qtile pacman:python-gobject pacman:gtk3 pip:gdk pip:psutil pip:dbus-next aur:python-iwlib aur:qtile-extras-git"
  deps_table[firefox]="pacman:firefox"
  deps_table[qutebrowser]="pacman:qutebrowser"
  deps_table[neovim]="pacman:neovim"
  deps_table[sddm]="pacman:sddm aur:sddm-theme-catppuccin-git aur:solarized-sddm-theme aur:multicolor-sddm-theme aur:sddm-chinese-painting-theme"
  deps_table[kitty]="pacman:kitty"
  deps_table[alacritty]="pacman:alacritty"
  deps_table[bash]="pacman:bash pip:virtualenvwrapper"
  deps_table[fish]="pacman:fish pacman:peco aur:ghq pip:virtualfish"
  deps_table[dmscripts]="aur:dmscripts"
  deps_table[scripts]="scripts"
  deps_table[fzf]="pacman:fzf"
  deps_table[catimg]="pacman:catimg"
  deps_table[chromium]="pacman:chromium"
  deps_table[emacs]="pacman:emacs pacman:ripgrep"
  deps_table[vim]="pacman:vim"
  deps_table[spacevim]="pacman:vim"
  deps_table[htop]="pacman:htop"
  deps_table[btop]="pacman:btop"
  deps_table[moc]="pacman:moc"
  deps_table[mpv]="pacman:mpv"
  deps_table[lf]="aur:lf"
  deps_table[discord]="pacman:discord aur:noto-fonts-emoji"
  deps_table[thunderbird]="pacman:thunderbird"
  deps_table[slack-desktop]="aur:slack-desktop"
  deps_table[signal-desktop]="pacman:signal-desktop"
  deps_table[caprine]="pacman:caprine"
  deps_table[lazygit]="pacman:lazygit"
  deps_table[tig]="pacman:tig"
  deps_table[rofi]="pacman:rofi"
  deps_table[conky]="pacman:conky"
  deps_table[pass]="pacman:pass"
  deps_table[nerd-fonts-mononoki]="aur:nerd-fonts-mononoki"
  deps_table[psutil]="pip:psutil"
  deps_table[dbus-next]="pip:dbus-next"
  deps_table[python-iwlib]="pacman:python-iwlib"
  deps_table[dunst]="pacman:dunst"
  deps_table[picom]="pacman:picom"
  deps_table[feh]="pacman:feh"
  deps_table[bspwm]="+xorg pacman:bspwm pacman:sxhkd"
  deps_table[spectrwm]="+xorg pacman:spectrwm"
  deps_table[shell-color-scripts]="aur:shell-color-scripts"

  # need to PKGBUILD them
  deps_table[wallpapers]="pkg:wallpapers/main pkg:mut-ex-wallpapers/arch/pkg +feh"
  deps_table[icons]="pkg:icons/main +feh"
  deps_table[arcologout]="aur:arcolinux-logout pacman:python-cairo"
  deps_table[dmenu]="pkg:dmenu/patch"
  deps_table[st]="pkg:st/patch"
  deps_table[tabbed]="pkg:tabbed/patch"
  deps_table[surf]="pkg:surf/patch pacman:gcr pacman:webkit2gtk pacman:xorg-xprop +tabbed"
  deps_table[slock]="pkg:slock/patch"
  deps_table[sfm]="pkg:sfm/pkgbuild"
  deps_table[dwm]="pkg:dwm/patch"

  # always add the base dependencies
  echo "${deps_table[base]}" | tr ' ' '\n' >> "$deps_file"
}

_confirm_driver () {
  #
  # show the currently selected driver
  # ask the user to change or the continue
  #
  DIALOGRC="$DRC" dialog --colors \
    --title "Selected driver: '$1'" \
    --no-label "Select this driver" \
    --yes-label "Change the driver" \
    --yesno "" 5 60 \
    --output-fd 1
  if [ "$?" == 0 ]; then
    echo "no driver"
  else
    echo "$1"
  fi
}
select_driver () {
  #
  # let the user choose among a list of available Arch
  # video drivers coming from the Arch Wiki,
  # https://wiki.archlinux.org/title/xorg#Driver_installation
  #
  # ask for a confirmation to let the user change the driver
  # when committing an error.
  #
  local driver="no driver"
  while [ "$driver" = "no driver" ]
  do
    # ask for the driver to use.
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
      9 "nvidia-390xx (NVIDIA**) (AUR)" \
      --output-fd 1 \
    )
    # ask for confirmation when the driver is valid
    # exit with an error otherwise.
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
      *) clear; error "no video driver selected";;
    esac
  done
  # register the driver as a dependency.
  case "$driver" in
    nvidia-470xx-dkms | nvidia-390xx) echo "yay:$driver" >> "$deps_file" ;;
    *) echo "pacman:$driver" >> "$deps_file" ;;
  esac

}

_confirm_deps () {
  #
  # show the currently list of selected dependencies
  # ask the user to change or the continue
  #
  local msg=""
  if [ "$1" = "" ];
  then
    msg="You have selected nothing\n\nAre You Sure You Really Want To Do That?"
  else
    msg=$(echo "$1" | tr ' ' '\n')
  fi
  DIALOGRC="$DRC" dialog --colors \
    --title "Selected dependencies:" \
    --no-label "Select" \
    --yes-label "Change" \
    --yesno "$msg" 16 60 \
    --output-fd 1
  if [ "$?" == 0 ]; then
    echo "1"
  else
    echo "0"
  fi
}
select_deps () {
  #
  # uses the `commands` field of the dependency table, the one
  # with `*:msg:state` elements, to build a checklist `dialog`
  # and let the user choose the software he wants when using
  # the `--action` switch in `interactive` mode.
  #
  local deps=""
  local loop=1
  # a fancy way to build the array, as `dialog` wants real arrays
  readarray -t dependencies <<< "$(sed "s/ /\n/g; s/:/\n/g" <<< "${_commands[@]}")"
  while [ "$loop" = 1 ]
  do
    # let the user check the list
    deps=$(DIALOGRC="$DRC" dialog --colors --clear \
      --title "Dependencies:" \
      --checklist "Choose" 20 48 16 \
      "${dependencies[@]}" \
      --output-fd 1 \
    )
    # exit on `dialog` error
    [ ! "$?" = 0 ] && return 1
    # ask for a confirmation before exiting
    loop=$(_confirm_deps "$deps")
  done
  # register all the dependencies
  # note the `+` in sed?, see the `build_deps` function below
  for dep in $(echo "$deps" | tr ' ' '\n'); do
    echo "$dep" | sed 's/^/+/' >> "$deps_file"
  done
}

push_all_deps () {
  #
  # when not in `interactive` mode, push all the
  # commands inside the dependencies
  #
  # this is mainly for people who really want to
  # try out every piece of the config, or simply
  # for myself, as I know these configs.
  #

  # note the `+` in sed?, see the `build_deps` function below
  echo "${_commands[@]}" | tr ' ' '\n' | sed "s/\(.*\)::.*/+\1/g" >> "$deps_file"
}

build_deps () {
  #
  # build the whole dependency list from a raw dependency list
  #
  # the raw list is a list of uncollapsed dependencies
  # an uncollapsed dependency `dep` begins with a `+` sign and needs
  # to be expanded using the `deps_table[dep]` dependency list
  #
  # for instance, if the raw list is "pacman:base-devel +qtile +kitty",
  # kitty has dependency list "pacman:kitty +fish" and qtile has
  # "pacman:qtile yay:nerd-fonts-mononoki",
  # base-devel is already expanded and will be installed with pacman
  # qtile and kitty are collapsed which brings the dependency list to
  # "pacman:base-devel pacman:qtile yay:nerd-fonts-mononoki pacman:kitty +fish"
  #
  # fish needs an other expansion
  # "pacman:base-devel pacman:qtile yay:nerd-fonts-mononoki pacman:kitty pacman:fish"
  #
  # everything is expanded, the algorithm stops with the final dependency list.
  #

  # as long as there are collapsed dependencies...
  while (grep -e "^+" "$deps_file" -q);
  do
    # ...cycle through each of them, ...
    for dep in $(grep -e "^+" "$deps_file"); do
      # ... remove the collapsed dependency...
      sed -i "s/$dep//g" "$deps_file"
      # ... and replace it with its children, which might be collapsed as well.
      echo "${deps_table[$(echo "$dep" | sed 's/+//')]}" | tr ' ' '\n' >> "$deps_file"
    done
  done

  # finally remove empty lines and sort
  sed -ir '/^\s*$/d' "$deps_file"
  sort -o "$deps_file" "$deps_file"
}

_install_pacman_deps () {
  #
  # install all the dependencies marked with "pacman:"
  # using `sudo pacman [flags] dep1 dep2 ...`
  #
  info "################################################################"
  info "## Installing pacman dependencies                             ##"
  info "################################################################"
  sudo pacman --needed --ask 4 -Sy $(grep -e "^pacman:" "$deps_file" | sed 's/^pacman://g' | tr '\n' ' ')
}

_install_paru () {
  #
  # install the paru AUR helper.
  #
  info "#################################################################"
  info "## Installing the paru Arch User Repositories package manager  ##"
  info "#################################################################"
  git clone https://aur.archlinux.org/paru.git "/tmp/paru"
  (
    cd "/tmp/paru" || return
    makepkg -si
  )
}

_install_aura () {
  #
  # install the aura AUR helper.
  #
  info "#################################################################"
  info "## Installing the aura Arch User Repositories package manager  ##"
  info "#################################################################"
  git clone https://aur.archlinux.org/aura-bin.git "/tmp/aura-bin"
  (
    cd "/tmp/aura-bin" || return
    makepkg
    sudo pacman -U ./*.pkg.tar.zst
  )
}

_install_yay () {
  #
  # install the yay AUR helper.
  #
  info "################################################################"
  info "## Installing the yay Arch User Repositories package manager  ##"
  info "################################################################"
  git clone https://aur.archlinux.org/yay-git.git "/tmp/yay-git"
  (
    cd "/tmp/yay-git" || return
    makepkg -si
  )
}

_install_aur_deps () {
  #
  # install all the dependencies marked with "aur:"
  # using `yay [flags] dep1 dep2 ...`
  #
  info "################################################################"
  info "## Installing aur dependencies                                ##"
  info "################################################################"
  yay --needed --ask 4 -Sy $(grep -e "^aur:" "$deps_file" | sed 's/^aur://g' | tr '\n' ' ')
}

_install_python_deps () {
  #
  # install all the dependencies marked with "pip:"
  # using `pip install dep1 dep2 ...`
  #
  info "################################################################"
  info "## Installing python dependencies                             ##"
  info "################################################################"
  pip install $(grep -e "^pip:" "$deps_file" | sed 's/^pip://g' | tr '\n' ' ')
}

_install_custom_pkgs () {
  #
  # install custom packages, i.e. dependencies marked with "pkg:"
  # by pulling their PKGBUILD from my repos, `makepkg`ing them and
  # `pacman`ing them
  #
  info "################################################################"
  info "## Installing custom packages of suckless software and others ##"
  info "################################################################"
  (
    cd /tmp || return
    for dep in $(grep -e "^pkg:" "$deps_file"); do
      repo_branch="$(echo "$dep" | sed 's/^pkg://')"
      # pull the PKGBUILD
      curl -fsSLo PKGBUILD "https://raw.githubusercontent.com/a2n-s/$repo_branch/PKGBUILD"
      makepkg -cf
    done
    sudo pacman -U -- *.pkg.tar.zst*
  )
}

install_deps () {
  #
  # install all the dependencies using the previous tool functions.
  #
  if grep -e "^pacman:" "$deps_file" -q; then _install_pacman_deps; fi
  if grep -e "^aur-helper:yay" "$deps_file" -q; then _install_yay; fi
  if grep -e "^aur-helper:aura" "$deps_file" -q; then _install_aura; fi
  if grep -e "^aur-helper:paru" "$deps_file" -q; then _install_paru; fi
  if grep -e "^aur:" "$deps_file" -q; then _install_aur_deps; fi
  if grep -e "^pip:" "$deps_file" -q; then _install_python_deps; fi
  if grep -e "^pkg:" "$deps_file" -q; then _install_custom_pkgs; fi
}

install_config () {
  #
  # install the dependencies configuration files when needed
  # each line is duplicated to add a bit color verbose to the
  # process and help the user know what is happening.
  #
  echo -e "${CMD}git clone ${SUB}-b $CHANNEL ${SRC}https://github.com/a2n-s/dotfiles ${DST}$DOTFILES${OFF}"
  git clone -b "$CHANNEL" https://github.com/a2n-s/dotfiles "$DOTFILES"
  if grep -e "^grub" "$deps_file" -q; then
    echo -e "${CMD}sudo grub-mkconfig ${DST}-o /boot/grub/grub.cfg${OFF}"
    sudo grub-mkconfig -o /boot/grub/grub.cfg
  fi
  if grep -e "^issue" "$deps_file" -q; then
    echo -e "${CMD}sudo cp ${SRC}"$DOTFILES/.config/etc/issue" ${DST}/etc/issue${OFF}"
    sudo cp "$DOTFILES/.config/etc/issue" /etc/issue
  fi
  if grep -e "^.*:sddm" "$deps_file" -q; then
    info "Enable sddm as login manager."
    echo -e "${CMD}sudo cp ${SRC}$DOTFILES/.config/etc/sddm.conf ${DST}/etc/sddm.conf${OFF}"
    sudo cp "$DOTFILES/.config/etc/sddm.conf" /etc/sddm.conf
    sudo systemctl disable "$(grep '/usr/s\?bin' /etc/systemd/system/display-manager.service | awk -F / '{print $NF}')" || warning "Cannot disable current display manager."
    echo -e "${CMD}sudo systemctl ${SUB}enable sddm${OFF}"
    sudo systemctl enable sddm
  else
    info "No login manager -> automatic startx on login"
    echo -e "${CMD}cp ${SRC}$DOTFILES/.xinitrc ${DST}$HOME/.xinitrc${OFF}"
    cp "$DOTFILES/.xinitrc" "$HOME/.xinitrc"
    echo -e "${CMD}cp ${SRC}$DOTFILES/.bash_profile ${DST}$HOME/.bash_profile${OFF}"
    cp "$DOTFILES/.bash_profile" "$HOME/.bash_profile"
  fi
  info "Install some basic configs."
  if grep -e "^.*:qtile" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/qtile ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/qtile" "$HOME/.config"
  fi
  if grep -e "^.*:bspwm" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/bspwm ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/bspwm" "$HOME/.config"
  fi
  if grep -e "^.*:spectrwm" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/spectrwm ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/spectrwm" "$HOME/.config"
  fi
  if grep -e "^.*:dunst" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/dunst ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/dunst" "$HOME/.config"
  fi
  if grep -e "^.*:picom" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/picom ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/picom" "$HOME/.config"
  fi
  if grep -e "^wallpapers:a2n-s/wallpapers" "$deps_file" -q; then
    echo -e "${CMD}git clone ${SRC}https://github.com/a2n-s/wallpapers ${DST}$HOME/ghq/githb.com/a2n-s/wallpapers${OFF}"
    git clone https://github.com/a2n-s/wallpapers "$HOME/ghq/github.com/a2n-s/wallpapers"
  fi
  if grep -e "^.*:qutebrowser" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/qutebrowser ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/qutebrowser" "$HOME/.config"
  fi
  if grep -e "^.*:kitty" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/kitty ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/kitty" "$HOME/.config"
  fi
  if grep -e "^.*:alacritty" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/alacritty ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/alacritty" "$HOME/.config"
  fi
  if grep -e "^.*:a2n-s/surf" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/surf ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/surf" "$HOME/.config"
  fi
  if grep -e "^.*:a2n-s/st" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/st ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/st" "$HOME/.config"
  fi
  if grep -e "^.*:neovim" "$deps_file" -q; then
    info "Installing my neovim rice"
    echo -e "${CMD}git clone ${SRC}https://github.com/a2n-s/nvim ${DST}$HOME/.config/nvim${OFF}"
    git clone https://github.com/a2n-s/nvim "$HOME/.config/nvim"
  fi
  if grep -e "^.*:emacs" "$deps_file" -q; then
    info "Installing doom Emacs"
    echo -e "${CMD}git clone ${SUB}--depth 1 ${SRC}https://github.com/hlissner/doom-emacs ${DST}$HOME/.emacs.d${OFF}"
    git clone --depth 1 https://github.com/hlissner/doom-emacs "$HOME/.emacs.d"
    echo -e "${CMD}bash -c ${SUB}$HOME/.emacs.d/bin/doom install${OFF}"
    bash -c "$HOME/.emacs.d/bin/doom install"
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.doom.d ${DST}$HOME/.doom.d${OFF}"
    cp -r "$DOTFILES/.doom.d" "$HOME/.doom.d"
    echo -e "${CMD}bash -c ${SUB}$HOME/.emacs.d/bin/doom sync${OFF}"
    bash -c "$HOME/.emacs.d/bin/doom sync"
    echo -e "${CMD}bash -c ${SUB}$HOME/.emacs.d/bin/doom doctor${OFF}"
    bash -c "$HOME/.emacs.d/bin/doom doctor"
  fi
  if grep -e "^.*:fish" "$deps_file" -q; then
    info "Install and configure the fish shell with oh-my-fish"
    echo -e "${CMD}curl -fsSLo ${DST}/tmp/omf.install ${SRC}https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install${OFF}; ${CMD}chmod +x ${SRC}/tmp/omf.install${OFF}; ${CMD}fish -c ${SUB}'/tmp/omf.install --noninteractive'${OFF}"
    curl -fsSLo /tmp/omf.install https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install; chmod +x /tmp/omf.install; fish -c "/tmp/omf.install --noninteractive"
    echo -e "${CMD}fish -c ${SUB}\"curl -sL ${SRC}https://git.io/fisher ${SUB}| ${DST}source ${SUB}&& fisher ${DST}install ${SRC}jorgebucaran/fisher${SUB}\"${OFF}"
    fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/fish ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/fish" "$HOME/.config"
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/omf ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/omf" "$HOME/.config"
    echo -e "${CMD}fish -c ${SUB}\"omf install\"${OFF}"
    fish -c "omf install"
    echo -e "${CMD}fish -c ${SUB}\"omf update\"${OFF}"
    fish -c "omf update"
    echo -e "${CMD}fish -c ${SUB}\"vf install\"${OFF}"
    fish -c "vf install"
    echo -e "${CMD}fish -c ${SUB}\"fisher update\"${OFF}"
    fish -c "fisher update"
  fi
  if grep -e "^.*:bash" "$deps_file" -q; then
    info "Configure the bash shell with oh-my-bash"
    echo -e "${CMD}curl -fsSL ${SRC}https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh${OFF} | ${CMD}bash -s ${OFF}-- ${SUB}--dry-run${OFF}"
    curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh | bash -s -- --dry-run
    echo -e "${CMD}cp ${SRC}$DOTFILES/.bashrc ${DST}$HOME/.bashrc${OFF}"
    cp "$DOTFILES/.bashrc" "$HOME/.bashrc"
    echo -e "${CMD}cp ${SRC}$DOTFILES/.bash_aliases ${DST}$HOME/.bash_aliases${OFF}"
    cp "$DOTFILES/.bash_aliases" "$HOME/.bash_aliases"
  fi
  info "Final miscellaneous configs."
  if grep -e "^.*:vim" "$deps_file" -q; then
    echo -e "${CMD}cp ${SRC}$DOTFILES/.vimrc ${DST}$HOME/.vimrc${OFF}"
    cp "$DOTFILES/.vimrc" "$HOME/.vimrc"
    echo -e "${CMD}mkdir -p ${DST}$HOME/.vim/pack/themes/start${OFF}"
    mkdir -p "$HOME/.vim/pack/themes/start"
    echo -e "${CMD}git clone ${SRC}https://github.com/dracula/vim.git ${DST}$HOME/.vim/pack/themes/start/dracula${OFF}"
    git clone https://github.com/dracula/vim.git "$HOME/.vim/pack/themes/start/dracula"
  fi
  if grep -e "^.*:spacevim" "$deps_file" -q; then
    echo -e "${CMD}curl -sLf ${SRC}https://spacevim.org/install.sh${OFF} | ${CMD}bash -s -- --install ${DST}vim${OFF}"
    curl -sLf https://spacevim.org/install.sh | bash -s -- --install vim
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.SpaceVim.d ${DST}$HOME/.SpaceVim.d${OFF}"
    cp -r "$DOTFILES/.SpaceVim.d" "$HOME/.SpaceVim.d"
  fi
  if grep -e "^git\$" "$deps_file" -q; then
    echo -e "${CMD}cp ${SRC}$DOTFILES/.gitconfig ${DST}$HOME/.gitconfig${OFF}"
    cp "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
  fi
  if grep -e "^.*:htop" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/htop ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/htop" "$HOME/.config"
  fi
  if grep -e "^.*:btop" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/btop ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/btop" "$HOME/.config"
  fi
  if grep -e "^.*:moc" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.moc ${DST}$HOME${OFF}"
    cp -r "$DOTFILES/.moc" "$HOME"
  fi
  if grep -e "^.*:mpv" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.mpv ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.mpv" "$HOME/.config"
  fi
  if grep -e "^scripts\$" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.local/bin ${DST}$HOME/.local${OFF}"
    cp -r "$DOTFILES/.local/bin" "$HOME/.local"
  fi
  if grep -e "^.*:dmscripts" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/dmscripts ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/dmscripts" "$HOME/.config"
  fi
  if grep -e "^.*:lf" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/lf ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/lf" "$HOME/.config"
  fi
  if grep -e "^.*:lazygit" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/lazygit ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/lazygit" "$HOME/.config"
  fi
  if grep -e "^.*:tig" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/tig ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/tig" "$HOME/.config"
  fi
  if grep -e "^.*:rofi" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/rofi ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/rofi" "$HOME/.config"
  fi
  if grep -e "^.*:conky" "$deps_file" -q; then
    echo -e "${CMD}cp -r ${SRC}$DOTFILES/.config/conky ${DST}$HOME/.config${OFF}"
    cp -r "$DOTFILES/.config/conky" "$HOME/.config"
  fi
  if grep -e "^.*:shell-color-scripts" "$deps_file" -q; then
    scriptstoban=(bomber pipes1 pipes2 pipes2-slim)
    for script in "${scriptstoban[@]}"; do
      colorscript --blacklist "$script" 2> /dev/null
    done
    echo "colorscripts banned"
  fi
}

prompt_shell () {
  #
  # prompt the user to change the default shell.
  #
  PS3="${GREEN}Set default user shell (enter number): ${OFF}"
  shells=("fish" "bash" "quit")
  select choice in "${shells[@]}"; do
      case $choice in
           fish | bash)
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
}

prompt_reboot () {
  #
  # prompt the user to reboot the system and apply
  # all the changes.
  #
  while true; do
      read -p "${GREEN}Do you want to reboot to get your new config?${OFF} [Y/n] " yn
      case $yn in
          [Yy]* ) sudo reboot;;
          [Nn]* ) break;;
          "" ) sudo reboot;;
          * ) echo "${RED}Please answer yes or no.${OFF}";;
      esac
  done
}

help () {
  #
  # the help function.
  #
  echo "install.sh:"
  echo "     This is the deployment script of my dotfiles"
  echo "     Software will be installed and configuration"
  echo "     files will be moved around the filesystem."
  echo ""
  echo "Usage:"
  echo "     install.sh [-hsfSrai]"
  echo ""
  echo "Switches:"
  echo "     -h/--help           shows this help."
  echo "     -s/--nosync         do not synchronize arch repos."
  echo "     -f/--nodialog       do not ask for confirmation."
  echo "     -S/--noshell        do not change the shell."
  echo "     -r/--reboot         reboot without asking."
  echo "     -a/--all            install everything"
  echo "     -i/--interactive    interactive install process"
  echo ""
  echo "Environment variables:"
  echo "     DOTFILES    the path where the dotfiles are pulled down  (defaults to \$HOME/.dotfiles.a2n-s)"
  echo "     CHANNEL     the branch of the dotfiles to use            (defaults to main)"
  exit 0
}

# parse the arguments.
OPTIONS=$(getopt -o hsrSfaid --long help,nosync,reboot,noshell,nodialog,action,interactive,debug \
              -n 'install.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

main () {
  #
  # the main function
  #

  # exit if ran as root
  if [ "$(id -u)" = 0 ]; then
    root_warning
  fi

  # interpret the switches.
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -s | --nosync ) NOSYNC="no"; shift 1 ;;
      -f | --nodialog ) NODIALOG="no"; shift 1 ;;
      -S | --noshell ) NOPROMPTSHELL="no"; shift 1 ;;
      -r | --reboot ) REBOOT="yes"; shift 1 ;;
      -a | --action ) ACTION="all"; shift 1 ;;
      -i | --interactive ) ACTION="interactive"; shift 1 ;;
      -d | --debug ) DEBUG="yes"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  echo "Massive changes have been implemented in all the repos of my github:"
  echo "  - repos have been renamed or removed"
  echo "  - some part of that config have been or are planned to be moved to standalone repos, e.g. ~/.local/bin will be moved shortly to https://github.com/a2n-s/scripts, if not already done"
  echo "  - PKGBUILD of custom applications have been moved https://github.com/a2n-s/pkgbuild"
  echo ""
  echo "In the end, I do not consider this script safe enough for now... So it is disabled for now."
  echo ""
  echo "If you really wanted to run that script, please contact me over on Github, the better being"
  echo "by opening an issue on https://github.com/a2n-s/scripts"
  exit 0

  # check if the action is valid.
  case "$ACTION" in
    all | interactive ) ;;
    '' ) warning "defaulting to interactive install"; ACTION="interactive" ;;
    * ) error "got unexpected action '$ACTION'" ;;
  esac

  # install
  [ ! -v NOSYNC ] && { sync_repos || error "Error syncing the repos."; }
  [ ! -v NODIALOG ] && { welcome || { [ ! -v DEBUG ] && clear; error "User choose to exit.";}; }
  [ ! -v NODIALOG ] && { lastchance || { [ ! -v DEBUG ] && clear; error "User choose to exit.";}; }
  init_deps || error "Error creating the dependencies file"
  select_driver || error "Video driver selection failed"
  [ "$ACTION" = "interactive" ] && { select_deps || { [ ! -v DEBUG ] && clear; error "User choose to exit";}; }
  [ "$ACTION" = "all" ] && { push_all_deps || error "Pushing all deps failed"; }
  clear
  build_deps || error "Building the dependencies failed."
  [ -v DEBUG ] && { less "$deps_file"; exit 0; }
  install_deps || error "Installing the dependencies failed."
  install_config || error "Installing the configuration files failed"

  info "####################################"
  info "## The config has been installed! ##"
  info "####################################"

  [ ! -v NOPROMPTSHELL ] && prompt_shell
  [ -v REBOOT ] && { sudo reboot; exit 0; }
  prompt_reboot
}

main "$@"
