#! /usr/bin/env bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#         _            __        ____              __
#        (_)___  _____/ /_____ _/ / /        _____/ /_
#       / / __ \/ ___/ __/ __ `/ / /        / ___/ __ \
#      / / / / (__  ) /_/ /_/ / / /   _    (__  ) / / /
#     /_/_/ /_/____/\__/\__,_/_/_/   (_)  /____/_/ /_/
#
# Description:  TODO
# Dependencies: TODO
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

################################################################################################
## Some color definitions ######################################################################
################################################################################################
# Reset
Off=$(printf '\033[0m')        # Text Reset
# Regular Colors
Blk=$(printf '\033[0;30m')     # Black
Red=$(printf '\033[0;31m')     # Red
Grn=$(printf '\033[0;32m')     # Green
Ylw=$(printf '\033[0;33m')     # Yellow
Blu=$(printf '\033[0;34m')     # Blue
Pur=$(printf '\033[0;35m')     # Purple
Cyn=$(printf '\033[0;36m')     # Cyan
Wht=$(printf '\033[0;37m')     # White
# Bold
BBlk=$(printf '\033[1;30m')    # Black
BRed=$(printf '\033[1;31m')    # Red
BGrn=$(printf '\033[1;32m')    # Green
BYlw=$(printf '\033[1;33m')    # Yellow
BBlu=$(printf '\033[1;34m')    # Blue
BPur=$(printf '\033[1;35m')    # Purple
BCyn=$(printf '\033[1;36m')    # Cyan
BWht=$(printf '\033[1;37m')    # White
# Underline
UBlk=$(printf '\033[4;30m')    # Black
URed=$(printf '\033[4;31m')    # Red
UGrn=$(printf '\033[4;32m')    # Green
UYlw=$(printf '\033[4;33m')    # Yellow
UBlu=$(printf '\033[4;34m')    # Blue
UPur=$(printf '\033[4;35m')    # Purple
UCyn=$(printf '\033[4;36m')    # Cyan
UWht=$(printf '\033[4;37m')    # White
# Background
OBlk=$(printf '\033[40m')      # Black
ORed=$(printf '\033[41m')      # Red
OGrn=$(printf '\033[42m')      # Green
OYlw=$(printf '\033[43m')      # Yellow
OBlu=$(printf '\033[44m')      # Blue
OPur=$(printf '\033[45m')      # Purple
OCyn=$(printf '\033[46m')      # Cyan
OWht=$(printf '\033[47m')      # White
# High Intensity
IBlk=$(printf '\033[0;90m')    # Black
IRed=$(printf '\033[0;91m')    # Red
IGrn=$(printf '\033[0;92m')    # Green
IYlw=$(printf '\033[0;93m')    # Yellow
IBlu=$(printf '\033[0;94m')    # Blue
IPur=$(printf '\033[0;95m')    # Purple
ICyn=$(printf '\033[0;96m')    # Cyan
IWht=$(printf '\033[0;97m')    # White
# Bold High Intensity
BIBlk=$(printf '\033[1;90m')   # Black
BIRed=$(printf '\033[1;91m')   # Red
BIGrn=$(printf '\033[1;92m')   # Green
BIYlw=$(printf '\033[1;93m')   # Yellow
BIBlu=$(printf '\033[1;94m')   # Blue
BIPur=$(printf '\033[1;95m')   # Purple
BICyn=$(printf '\033[1;96m')   # Cyan
BIWht=$(printf '\033[1;97m')   # White
# High Intensity backgrounds
OIBlk=$(printf '\033[0;100m')  # Black
OIRed=$(printf '\033[0;101m')  # Red
OIGrn=$(printf '\033[0;102m')  # Green
OIYlw=$(printf '\033[0;103m')  # Yellow
OIBlu=$(printf '\033[0;104m')  # Blue
OIPur=$(printf '\033[0;105m')  # Purple
OICyn=$(printf '\033[0;106m')  # Cyan
OIWht=$(printf '\033[0;107m')  # White

################################################################################################
## 'Global constants' definitions ##############################################################
################################################################################################
# Specific color use. #
#######################
Err=$IRed  # errors
Wrn=$IYlw  # warnings
Crt=$Red   # critical
Cmd=$IBlu  # command
Src=$Pur   # source
Dst=$Grn   # destination
Nrm=$IWht  # normal
Pmt=$Cyn   # prompt
Pkg=$Ylw   # package
Tip=$IGrn  # tip
Url=$IYlw  # url

Normal="${Nrm}[.]${Off}"
Prompt="${Pmt}[?]${Off}"
Warning="${Wrn}[*]${Off}"
Critic="${Crt}[-]${Off}"
Error="${Err}[!]${Off}"

#######################
# all the repos I use #
#######################
declare -A repositories
repositories["prog/sketchbook/FastLED-basics"]="git@github.com:s-marley/FastLED-basics.git "
repositories["prog/scsc/fil-rouge"]="git@github.com:a2n-s/fil-rouge.git git@github.com:iScsc/fil-rouge.git"
repositories["prog/scsc/fgk"]="git@github.com:a2n-s/fgk.git "
repositories["prog/swarm-rescue-g1"]="git@github.com:a2n-s/swarm-rescue-g1.git git@github.com:atxr/swarm-rescue-g1.git"
repositories["sup/tatami"]="https://github.com/a2n-s/tatami.git "
repositories["sup/machine-learning"]="git@github.com:a2n-s/machine-learning.git git@github.com:SupaeroDataScience/machine-learning.git"
repositories["sup/imgDesc"]="git@github.com:a2n-s/imgDesc.git "
repositories["sup/flatland-project"]="git@github.com:abfariah/flatland-project.git https://github.com/SupaeroDataScience/flatland-project"
repositories["sup/deep-learning"]="git@github.com:a2n-s/deep-learning.git git@github.com:SupaeroDataScience/deep-learning.git"
repositories["sup/stochastic"]="git@github.com:a2n-s/stochastic.git https://github.com/SupaeroDataScience/stochastic.git"
repositories["sup/mcdm"]="git@github.com:a2n-s/mcdm.git "
repositories["surf"]="git@github.com:a2n-s/surf.git git://git.suckless.org/surf"
repositories["yay-git"]="https://aur.archlinux.org/yay-git.git "
repositories["polybar"]="git@github.com:a2n-s/polybar-themes.git git@github.com:adi1090x/polybar-themes.git"
repositories["lazycli"]="git@github.com:jesseduffield/lazycli.git "
repositories["dmscripts"]="git@github.com:a2n-s/dmscripts.git https://gitlab.com/dwt1/dmscripts.git"
repositories["dmenu"]="git@github.com:a2n-s/dmenu.git git://git.suckless.org/dmenu"
repositories["tabbed"]="git@github.com:a2n-s/tabbed.git git://git.suckless.org/tabbed"
repositories["slock"]="git@github.com:a2n-s/slock.git https://git.suckless.org/slock"
repositories["bash-insulter"]="git@github.com:a2n-s/bash-insulter.git "
repositories["kitty"]="git@github.com:a2n-s/kitty.git git@github.com:kovidgoyal/kitty.git"
repositories["Neovim-from-scratch"]="git@github.com:LunarVim/Neovim-from-scratch.git "
repositories["oh-my-bash"]="git@github.com:a2n-s/oh-my-bash.git git@github.com:ohmybash/oh-my-bash.git"
repositories["uzbl"]="git://github.com/uzbl/uzbl.git "
repositories["oh-my-fish"]="git@github.com:a2n-s/oh-my-fish.git git@github.com:oh-my-fish/oh-my-fish.git"
repositories["a2n-s"]="git@github.com:a2n-s/a2n-s.git "
repositories["wallpapers"]="git@github.com:a2n-s/wallpapers.git "
repositories["oh-my-zsh"]="git@github.com:a2n-s/ohmyzsh.git git@github.com:ohmyzsh/ohmyzsh.git"
repositories["sites/nereuxofficial.github.io"]="git@github.com:Nereuxofficial/nereuxofficial.github.io.git "
repositories["sites/a2n-s.github.io/themes/hugo-theme-terminal"]="git@github.com:a2n-s/hugo-theme-terminal.git git@github.com:panr/hugo-theme-terminal.git"
repositories["sites/a2n-s.github.io"]="git@github.com:a2n-s/a2n-s.github.io.git "
repositories["dotfiles/atxr_dotfiles"]="https://github.com/atxr/dotfiles.git "
repositories["research/playground_env"]="git@github.com:flowersteam/playground_env.git "
repositories["research/Imagine"]="https://github.com/flowersteam/Imagine.git "
repositories["research/imagineXdial"]="https://github.com/SuReLI/imagineXdial.git "
repositories["research/gym_ma_toy"]="https://github.com/MehdiZouitine/gym_ma_toy "
repositories["research/learning-to-communicate-pytorch"]="https://github.com/minqi/learning-to-communicate-pytorch.git "

###############
# my scripts. #
###############
scripts=()
scripts+=("_countdown.sh")
scripts+=("_parse_git_info.sh")
scripts+=("_shortwd.sh")
scripts+=("_stopwatch.sh")
scripts+=("dmrun.sh")
scripts+=("lfrun.sh")
scripts+=("list.git-repos.diagnostic.sh")
scripts+=("misc.nvim-renaming.sh")
scripts+=("prompt.sh")
scripts+=("repo.info.sh")
scripts+=("screenshot.sh")
scripts+=("slock-cst.sh")
scripts+=("spectrWM-baraction.sh")
scripts+=("togkb.sh")
scripts+=("tr2md.sh")
scripts+=("upl.sh")
scripts+=("wvenv.sh")
scripts+=("xtcl.sh")
scripts+=("ytdl.sh")

##########################
# installation constants #
##########################
DIR=`pwd`
HDIR="$HOME"
CDIR=".config"
SDIR="scripts"
RDIR="repos"

################################################################################################

################################################################################################
## script installation functions ###############################################################
################################################################################################
install_script() {
  if [[ -f "$HDIR/$SDIR/$1" ]]; then
    echo "$HDIR/$SDIR/$1 already exists"
    if [[ -f "$DIR/old/$SDIR/$1" ]]; then
      read -p "$Prompt ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
      case "$REPLY" in
        1|"o")  echo "${Crt}mv ${Src}$HDIR/$SDIR/$1 ${Dst}$DIR/old/$SDIR/$1${Off}"
                mv $HDIR/$SDIR/$1 $DIR/old/$SDIR/$1
        ;;
        2|"k")  echo "${Wrn}Keeping previous backup file.${Off}"
        ;;
        *) echo "${Wrn}Keeping previous backup file.${Off}"
        ;;
      esac
    else
      echo "${Crt}mv ${Src}$HDIR/$SDIR/$1 ${Dst}$DIR/old/$SDIR/$1${Off}"
      mv $HDIR/$SDIR/$1 $DIR/old/$SDIR/$1
    fi
    echo "${Cmd}cp -rf ${Src}$DIR/$SDIR/$1 ${Dst}$HDIR/$SDIR/$1${Off}"
    cp -rf $DIR/$SDIR/$1 $HDIR/$SDIR/$1
  else
    echo "${Cmd}cp -rf ${Src}$DIR/$SDIR/$1 ${Dst}$HDIR/$SDIR/$1${Off}"
    cp -rf $DIR/$SDIR/$1 $HDIR/$SDIR/$1
  fi
  echo "${Tip}[!!] Doc for this particular script is available at ${Url}https://a2n-s.github.io/public/doc/config/scripts/$1 ${Off}"
}

################################################################################################
## general configuration files installation functions ##########################################
################################################################################################
# tools #
#########
install_dir() {
  if [[ -d "$HDIR/$1" ]]; then
    echo "${Wrn}$HDIR/$1 already exists${Off}"
    if [[ -d "$DIR/old/$1" ]]; then
      read -p "$Prompt ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
      case "$REPLY" in
        1|"o")  echo "${Crt}mv ${Src}$HDIR/$1/* ${Dst}$DIR/old/$1${Off}"
                mv $HDIR/$1/* $DIR/old/$1
        ;;
        2|"k")  echo "${Wrn}Keeping previous backup file.${Off}"
        ;;
        *) echo "${Wrn}Keeping previous backup file.${Off}"
        ;;
      esac
    else
      echo "${Wrn}mkdir -p $DIR/old/$1${Off}"
      mkdir -p $DIR/old/$1
      echo "${Crt}mv ${Src}$HDIR/$1/* ${Dst}$DIR/old/$1${Off}"
      mv $HDIR/$1/* $DIR/old/$1
    fi
    echo "${Cmd}cp -rf ${Src}$DIR/$1/* ${Dst}$HDIR/$1${Off}"
    cp -rf $DIR/$1/* $HDIR/$1
  else
    echo "${Wrn}$HDIR/$1 does not exist${Off}"
    echo "${Wrn}mkdir -p $HDIR/$1${Off}"
    mkdir -p $HDIR/$1
    echo "${Cmd}cp -rf ${Src}$DIR/$1/* ${Dst}$HDIR/$1${Off}"
    cp -rf $DIR/$1/* $HDIR/$1
  fi
}
install_file() {
  if [[ -f "$HDIR/$1" ]]; then
    echo "$HDIR/$1 already exists"
    if [[ -f "$DIR/old/$1" ]]; then
      read -p "$Prompt ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup 1. "
      case "$REPLY" in
        1|"o")  echo "${Crt}mv ${Src}$HDIR/$1 ${Dst}$DIR/old/$1${Off}"
                mv $HDIR/$1 $DIR/old/$1
        ;;
        2|"k")  echo "${Wrn}Keeping previous backup 1.${Off}"
        ;;
        *) echo "${Wrn}Keeping previous backup 1.${Off}"
        ;;
      esac
    else
      echo "${Crt}mv ${Src}$HDIR/$1 ${Dst}$DIR/old/$1${Off}"
      mv $HDIR/$1 $DIR/old/$1
    fi
    echo "${Cmd}cp -rf ${Src}$DIR/$1 ${Dst}$HDIR/$1${Off}"
    cp -rf $DIR/$1 $HDIR/$1
  else
    echo "${Cmd}cp -rf ${Src}$DIR/$1 ${Dst}$HDIR/$1${Off}"
    cp -rf $DIR/$1 $HDIR/$1
  fi
}
###########################################################
# all the different configurations in their own functions #
###########################################################
install_git() {
  install_file ".gitconfig"
  echo "${Cmd}sudo pacman -Syu ${Pkg}git${Off}"
  sudo pacman -Syu git
  
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/git ${Off}"
}
install_htop() {
  install_dir ".config/htop"
  echo "${Cmd}sudo pacman -Syu ${Pkg}htop${Off}"
  sudo pacman -Syu htop
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/htop ${Off}"
}
install_bash() {
  install_file ".bash_logout"
  install_file ".bash_profile"
  install_file ".bashrc"
  install_file ".profile"
  echo "${Cmd}sudo pacman -Syu ${Pkg}ponysay fortune${Off}"
  sudo pacman -Syu ponysay fortune
  if [[ -d $HDIR/$RDIR/oh-my-bash ]]; then
    echo "${Wrn}$HDIR/$RDIR/oh-my-bash already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/oh-my-bash before trying again${Off}"
  else
    echo "${Cmd}git clone git://github.com/a2n-s/oh-my-bash.git $HDIR/$RDIR/oh-my-bash${Off}"
    git clone git://github.com/a2n-s/oh-my-bash.git $HDIR/$RDIR/oh-my-bash
  fi
  echo "${Cmd}sudo wget -O /etc/bash.command-not-found https://raw.githubusercontent.com/hkbakke/bash-insulter/master/src/bash.command-not-found${Off}"
  sudo wget -O /etc/bash.command-not-found https://raw.githubusercontent.com/hkbakke/bash-insulter/master/src/bash.command-not-found
  echo "${Cmd}pip install virtualenvwrapper${Off}"
  pip install virtualenvwrapper
  echo "${Cmd}yay -S ${Pkg}shell-color-scripts${Off}"
  yay -S shell-color-scripts
  echo "${Tip}[!!] Do not forget to source your ~/.bashrc for the config to take full effect.${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/bash ${Off}and ${Url}https://a2n-s.github.io/public/doc/config/bash ${Off}"
}
install_starship() {
  install_file ".config/starship.toml"
  echo "${Cmd}yay -S ${Pkg}nerd-fonts-mononoki${Off}"
  yay -S nerd-fonts-mononoki
  echo "${Cmd}sudo pacman -Syu ${Pkg}starship${Off}"
  sudo pacman -Syu starship
  echo "${Tip}[!!] Do not forget to source your ~/.bashrc for the config to take full effect.${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/starship ${Off}"
}
install_neofetch() {
  install_dir ".config/neofetch"
  echo "${Cmd}sudo pacman -Syu ${Pkg}neofetch pr${Off}"
  sudo pacman -Syu neofetch pr
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/neofetch ${Off}"
}
install_vim() {
  install_file ".vimrc"
  echo "${Cmd}sudo pacman -Syu ${Pkg}vim${Off}"
  sudo pacman -Syu vim
  echo "${Cmd}mkdir -p $HDIR/.vim $HDIR/.vim/autoload $HDIR/.vim/backup $HDIR/.vim/color $HDIR/.vim/plugged${Off}"
  mkdir -p $HDIR/.vim $HDIR/.vim/autoload $HDIR/.vim/backup $HDIR/.vim/color $HDIR/.vim/plugged
  echo "${Cmd}curl -fLo $HDIR/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim${Off}"
  curl -fLo $HDIR/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "${Cmd}curl -fLo $HDIR/.vim/colors/molokai.vim --create-dirs https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim${Off}"
  curl -fLo $HDIR/.vim/colors/molokai.vim --create-dirs https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
  echo "${Tip}[!!] To install the plugins, run vim and then :PlugInstall in the command line.${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/vim ${Off}"
}
install_neovim() {
  echo "${Cmd}sudo pacman -Syu ${Pkg}nvim${Off}"
  sudo pacman -Syu nvim
  if [[ -d $HDIR/.config/nvim ]]; then
    echo "${Wrn}$HDIR/.config/nvim already exists${Off}"
    echo "${Wrn}please backup $HDIR/.config/nvim before trying again${Off}"
  else
    echo "${Cmd}git clone https://github.com/a2n-s/neovim $HDIR/.config/nvim${Off}"
    git clone https://github.com/a2n-s/neovim $HDIR/.config/nvim
  fi
  echo "${Tip}[!!] You are encouraged to backup your plugins and LSP servers, usually located in ~/.local/share/nvim if any at all.${Off}"
  echo "${Tip}[!!] Run nvim at least once to install plugins.${Off}"
  echo "${Tip}[!!] Run :LSPInstallInfo or press <space>lI to enter the same menu. Then select the servers you want with i to install or u to update.${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/neovim ${Off}"
}
install_x() {
  install_file ".xinitrc"
  echo "${Cmd}sudo pacman -Syu ${Pkg}xorg picom${Off}"
  sudo pacman -Syu xorg picom
  echo "${Tip}[!!] Do not forget to restart your session for x config to kick in. If it does not:${Off}"
  echo "${Tip}[!!]   - check that the uncommented windows manager in ~/.xinitrc is installed and ready to run${Off}"
  echo "${Tip}[!!]   - you can always fallback to other ttys of your machine. It might be by pressing <ctrl-alt-fn> where n is the number of the tty.${Off}"
  echo "${Tip}[!!]     The default, and the one which is running ~/.xinitrc, is tty1. I have 6 ttys on my machine. There x won't bother anyone!${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/x ${Off}"
}
install_bspwm() {
  install_dir ".config/bspwm"
  install_dir ".config/sxhkd"
  echo "${Cmd}sudo pacman -Syu ${Pkg}bspwm feh${Off}"
  sudo pacman -Syu bspwm feh
  echo "${Cmd}sudo pacman -Syu ${Pkg}sxhkd${Off}"
  sudo pacman -Syu sxhkd
  echo "${Tip}[!!] Be sure to restart you x server or at least bspwm and sxhkd for the config to take full effect.${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/bspwm ${Off}and ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/sxhkd ${Off}"
}
install_spectrwm() {
  install_dir ".config/spectrwm"
  echo "${Cmd}sudo pacman -Syu ${Pkg}spectrwm${Off}"
  sudo pacman -Syu spectrwm
  echo "${Tip}[!!] Be sure to restart you x server or at least spectrwm for the config to take full effect.${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/spectrwm ${Off}"
}
install_alacritty() {
  install_dir ".config/alacritty"
  echo "${Cmd}yay -S ${Pkg}nerd-fonts-mononoki${Off}"
  yay -S nerd-fonts-mononoki
  echo "${Cmd}sudo pacman -Syu ${Pkg}alacritty${Off}"
  sudo pacman -Syu alacritty
  echo "${Tip}[!!] Be sure to restart the right terminal emulator for the config to take full effect.${Off}"
  echo "${Tip}[!!] You might need to tell youre wm to use alacritty as default, or just run alacritty in your previous terminal.${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/alacritty ${Off}"
}
install_kitty() {
  install_dir ".config/kitty"
  if [[ -d $HDIR/$RDIR/kitty ]]; then
    echo "${Wrn}$HDIR/$RDIR/kitty already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/kitty before trying again${Off}"
  else
    echo "${Cmd}git clone https://github.com/a2n-s/kitty $HDIR/$RDIR/kitty${Off}"
    git clone https://github.com/a2n-s/kitty $HDIR/$RDIR/kitty
  fi
  echo "${Cmd}cd $HDIR/$RDIR/kitty${Off}"
  cd $HDIR/$RDIR/kitty
  echo "${Cmd}git checkout main${Off}"
  git checkout main
  echo "${Cmd}make${Off}"
  make
  echo "${Cmd}ln -s ./kitty/launcher/kitty /usr/bin/kitty${Off}"
  ln -s ./kitty/launcher/kitty /usr/bin/kitty
  echo "${Tip}[!!] Be sure to restart the right terminal emulator for the config to take full effect.${Off}"
  echo "${Tip}[!!] You might need to tell youre wm to use kitty as default, or just run kitty in your previous terminal.${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/kitty ${Off}"
}
install_nitrogen() {
  install_dir ".config/nitrogen"
  echo "${Cmd}sudo pacman -Syu ${Pkg}nitrogen${Off}"
  sudo pacman -Syu nitrogen
  echo "${Tip}[!!] You might need to run nitrogen once to setup it and/or restart your wm for the wallpaper to kick in.${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/nitrogen ${Off}"
}
install_slock() {
  if [[ -d $HDIR/$RDIR/slock ]]; then
    echo "${Wrn}$HDIR/$RDIR/slock already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/slock before trying again${Off}"
  else
    echo "${Cmd}git clone https://github.com/a2n-s/slock $HDIR/$RDIR/slock${Off}"
    git clone https://github.com/a2n-s/slock $HDIR/$RDIR/slock
  fi
  echo "${Cmd}cd $HDIR/$RDIR/slock${Off}"
  cd $HDIR/$RDIR/slock
  echo "${Cmd}git checkout main${Off}"
  git checkout main
  echo "${Cmd}make clean install${Off}"
  make clean install
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/slock ${Off}"
}
install_xscreensaver() {
  install_file ".xscreensaver"
  echo "${Cmd}sudo pacman -Syu ${Pkg}xscreensaver${Off}"
  sudo pacman -Syu xscreensaver
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/xscreensaver ${Off}"
}
install_polybar() {
  echo "${Cmd}sudo pacman -Syu ${Pkg}polybar${Off}"
  sudo pacman -Syu polybar
  if [[ -d $HDIR/$RDIR/polybar ]]; then
    echo "${Wrn}$HDIR/$RDIR/polybar already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/polybar before trying again${Off}"
  else
    echo "${Cmd}git clone --depth=1 https://github.com/a2n-s/polybar-themes.git $HDIR/$RDIR/polybar${Off}"
    git clone --depth=1 https://github.com/a2n-s/polybar-themes.git $HDIR/$RDIR/polybar
  fi
  echo "${Cmd}chmod +x $HDIR/$RDIR/polybar/setup.sh${Off}"
  chmod +x $HDIR/$RDIR/polybar/setup.sh
  echo "${Cmd}$HDIR/$RDIR/polybar/setup.sh${Off}"
  $HDIR/$RDIR/polybar/setup.sh
  echo "${Tip}[!!] Do not forget to launch the bar by either running my bspwm config or running \`bash \$HOME/.config/polybar/launch.sh --forest &\`${Off}"
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/polybar ${Off}"
}
install_vifm() {
  install_dir ".config/vifm"
  echo "${Cmd}sudo pacman -Syu ${Pkg}vifm${Off}"
  sudo pacman -Syu vifm
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/vifm ${Off}"
}
install_tmux() {
  install_file ".tmux.conf"
  echo "${Cmd}sudo pacman -Syu ${Pkg}tmux${Off}"
  sudo pacman -Syu tmux
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/tmux ${Off}"
}
install_surf() {
  install_dir ".config/surf"
  if [[ -d $HDIR/$RDIR/surf ]]; then
    echo "${Wrn}$HDIR/$RDIR/surf already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/surf before trying again${Off}"
  else
    echo "${Cmd}git clone https://github.com/a2n-s/surf $HDIR/$RDIR/surf${Off}"
    git clone https://github.com/a2n-s/surf $HDIR/$RDIR/surf
  fi
  echo "${Cmd}cd $HDIR/$RDIR/surf${Off}"
  cd $HDIR/$RDIR/surf
  echo "${Cmd}git checkout main${Off}"
  git checkout main
  echo "${Cmd}make clean install${Off}"
  make clean install
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/surf ${Off}"
}
install_tabbed() {
  if [[ -d $HDIR/$RDIR/tabbed ]]; then
    echo "${Wrn}$HDIR/$RDIR/tabbed already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/tabbed before trying again${Off}"
  else
    echo "${Cmd}git clone https://github.com/a2n-s/tabbed $HDIR/$RDIR/tabbed${Off}"
    git clone https://github.com/a2n-s/tabbed $HDIR/$RDIR/tabbed
  fi
  echo "${Cmd}cd $HDIR/$RDIR/tabbed${Off}"
  cd $HDIR/$RDIR/tabbed
  echo "${Cmd}git checkout main${Off}"
  git checkout main
  echo "${Cmd}make clean install${Off}"
  make clean install
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/tabbed ${Off}"
}
install_wallpapers() {
  if [[ -d $HDIR/$RDIR/wallpapers ]]; then
    echo "${Wrn}$HDIR/$RDIR/wallpapers already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/wallpapers before trying again${Off}"
  else
    echo "${Cmd}git clone https://github.com/a2n-s/wallpaper $HDIR/$RDIR/wallpapers${Off}"
    git clone https://github.com/a2n-s/wallpaper $HDIR/$RDIR/wallpapers
  fi
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/wallpapers ${Off}"
}
install_dmenu() {
  if [[ -d $HDIR/$RDIR/dmenu ]]; then
    echo "${Wrn}$HDIR/$RDIR/dmenu already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/dmenu before trying again${Off}"
  else
    echo "${Cmd}git clone https://github.com/a2n-s/dmenu $HDIR/$RDIR/dmenu${Off}"
    git clone https://github.com/a2n-s/dmenu $HDIR/$RDIR/dmenu
  fi
  echo "${Cmd}cd $HDIR/$RDIR/dmenu${Off}"
  cd $HDIR/$RDIR/dmenu
  echo "${Cmd}git checkout main${Off}"
  git checkout main
  echo "${Cmd}make clean install${Off}"
  make clean install
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dmenu ${Off}"
}
install_dmscripts() {
  install_dir ".config/dmscripts"
  if [[ -d $HDIR/$RDIR/dmscripts ]]; then
    echo "${Wrn}$HDIR/$RDIR/dmscripts already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/dmscripts before trying again${Off}"
  else
    echo "${Cmd}git clone https://github.com/a2n-s/dmscripts $HDIR/$RDIR/dmscripts${Off}"
    git clone https://github.com/a2n-s/dmscripts $HDIR/$RDIR/dmscripts
  fi
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dmscripts ${Off}"
}
install_fish() {
  install_dir ".config/fish"
  echo "${Cmd}sudo pacman -Syu ${Pkg}fish${Off}"
  sudo pacman -Syu fish
  if [[ -d $HDIR/$RDIR/oh-my-fish ]]; then
    echo "${Wrn}$HDIR/$RDIR/oh-my-fish already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/oh-my-fish before trying again${Off}"
  else
    echo "${Cmd}git clone git://github.com/a2n-s/oh-my-fish.git $HDIR/$RDIR/oh-my-fish${Off}"
    git clone git://github.com/a2n-s/oh-my-fish.git $HDIR/$RDIR/oh-my-fish
  fi
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/fish ${Off}"
}
install_lazygit() {
  install_dir ".config/lazygit"
  echo "${Cmd}sudo pacman -Syu ${Pkg}lazygit${Off}"
  sudo pacman -Syu lazygit
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/lazygit ${Off}(${Red}NOT AVAILABLE FOR NOW${Off})"
}
install_lf() {
  install_dir ".config/lf"
  echo "${Cmd}yay -S ${Pkg}lf${Off}"
  yay -S lf
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/lf ${Off}(${Red}NOT AVAILABLE FOR NOW${Off})"
}
install_mpd() {
  install_dir ".config/mpd"
  echo "${Cmd}sudo pacman -Syu ${Pkg}mpd${Off}"
  sudo pacman -Syu mpd
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/mpd ${Off}(${Red}NOT AVAILABLE FOR NOW${Off})"
}
install_mpv() {
  install_dir ".config/mpv"
  echo "${Cmd}sudo pacman -Syu ${Pkg}mpv${Off}"
  sudo pacman -Syu mpv
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/mpv ${Off}(${Red}NOT AVAILABLE FOR NOW${Off})"
}
install_ncmpcpp() {
  install_dir ".config/ncmpcpp"
  echo "${Cmd}sudo pacman -Syu ${Pkg}ncmpcpp${Off}"
  sudo pacman -Syu ncmpcpp
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/ncmpcpp ${Off}(${Red}NOT AVAILABLE FOR NOW${Off})"
}
install_tigrc() {
  install_dir ".config/tigrc"
  echo "${Cmd}sudo pacman -Syu ${Pkg}tig${Off}"
  sudo pacman -Syu tig
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/dotfiles/tig ${Off}(${Red}NOT AVAILABLE FOR NOW${Off})"
}
install_zsh() {
  install_file ".zshrc"
  echo "${Cmd}sudo pacman -Syu ${Pkg}zsh${Off}"
  sudo pacman -Syu zsh
  if [[ -d $HDIR/$RDIR/oh-my-zsh ]]; then
    echo "${Wrn}$HDIR/$RDIR/oh-my-zsh already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/oh-my-zsh before trying again${Off}"
  else
    echo "${Cmd}git clone git://github.com/a2n-s/ohmyzsh.git $HDIR/$RDIR/oh-my-zsh${Off}"
    git clone git://github.com/a2n-s/ohmyzsh.git $HDIR/$RDIR/oh-my-zsh
  fi
  echo "${Tip}[!!] Doc for this particular config is available at ${Url}https://a2n-s.github.io/public/doc/config/zsh ${Off}"
}

################################################################################################
## standalone repos installation functions #####################################################
################################################################################################
install_repo() {
  r_path=$1
  r_origin=$(echo ${repositories[$1]} | awk '{print $1}')
  r_upstream=$(echo ${repositories[$1]} | awk '{print $2}')
  if [[ -d $HDIR/$RDIR/$r_path ]]; then
    echo "${Wrn}$HDIR/$RDIR/$r_path already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/$r_path before trying again${Off}"
  else
    echo "${Crt}$HDIR/$RDIR/$r_path does not exist${Off}"
    echo "${Wrn}mkdir -p $HDIR/$RDIR/$(dirname $r_path)${Off}"
    mkdir -p $HDIR/$RDIR/$(dirname $r_path)
    echo -e "${Cmd}git clone ${Src}$r_origin ${Dst}$HDIR/$RDIR/$r_path${Off}"
    git clone $r_origin $HDIR/$RDIR/$r_path
    if [[ ! $r_upstream == "" ]]; then
      echo -e "${Cmd}git -C ${Dst}$HDIR/$RDIR/$r_path ${Cmd}remote add upstream ${Src}$r_upstream${Off}"
      git -C $HDIR/$RDIR/$r_path remote add upstream $r_upstream
      echo -e "${Cmd}git -C ${Dst}$HDIR/$RDIR/$r_path ${Cmd}fetch upstream --prune${Off}"
      git -C $HDIR/$RDIR/$r_path fetch upstream --prune
    fi
  fi
}

################################################################################################
## font installation functions #################################################################
################################################################################################
install_font() {
	echo -ne "\n$Normal Available soon..."
}

################################################################################################
## tools and wrapping up #######################################################################
################################################################################################
prompt_for_install_and_install() {
  echo ""
  read -p "$Prompt $2 ${Cyn}(y/n/q)${Off} "
  case "$REPLY" in
    "y")  $1
    ;;
    "n")  echo "$Warning Skipping!"
    ;;
    "q")  echo "$Critic Aborting!"
          exit 1
    ;;
    *) echo -e "$Error Invalid Option, Skipping..."
    ;;
  esac
}

display_center(){
    columns="$(tput cols)"
    printf "%*s\n" $(( (${#1} + columns) / 2)) "$1"
}

init_CFG() {
  CFG["REPO:prog/sketchbook/FastLED-basics"]="none"
  CFG["REPO:prog/scsc/fil-rouge"]="none"
  CFG["REPO:prog/scsc/fgk"]="none"
  CFG["REPO:prog/swarm-rescue-g1"]="none"
  CFG["REPO:sup/tatami"]="none"
  CFG["REPO:sup/machine-learning"]="none"
  CFG["REPO:sup/imgDesc"]="none"
  CFG["REPO:sup/flatland-project"]="none"
  CFG["REPO:sup/deep-learning"]="none"
  CFG["REPO:sup/stochastic"]="none"
  CFG["REPO:sup/mcdm"]="none"
  CFG["REPO:surf"]="none"
  CFG["REPO:yay-git"]="none"
  CFG["REPO:polybar"]="none"
  CFG["REPO:lazycli"]="none"
  CFG["REPO:dmscripts"]="none"
  CFG["REPO:dmenu"]="none"
  CFG["REPO:tabbed"]="none"
  CFG["REPO:slock"]="none"
  CFG["REPO:bash-insulter"]="none"
  CFG["REPO:kitty"]="none"
  CFG["REPO:Neovim-from-scratch"]="none"
  CFG["REPO:oh-my-bash"]="none"
  CFG["REPO:uzbl"]="none"
  CFG["REPO:oh-my-fish"]="none"
  CFG["REPO:a2n-s"]="none"
  CFG["REPO:wallpapers"]="none"
  CFG["REPO:oh-my-zsh"]="none"
  CFG["REPO:sites/nereuxofficial.github.io"]="none"
  CFG["REPO:sites/a2n-s.github.io/themes/hugo-theme-terminal"]="none"
  CFG["REPO:sites/a2n-s.github.io"]="none"
  CFG["REPO:dotfiles/atxr_dotfiles"]="none"
  CFG["REPO:research/playground_env"]="none"
  CFG["REPO:research/Imagine"]="none"
  CFG["REPO:research/imagineXdial"]="none"
  CFG["REPO:research/gym_ma_toy"]="none"
  CFG["REPO:research/learning-to-communicate-pytorch"]="none"

  CFG["SCRIPT:_countdown.sh"]="none"
  CFG["SCRIPT:_parse_git_info.sh"]="none"
  CFG["SCRIPT:_shortwd.sh"]="none"
  CFG["SCRIPT:_stopwatch.sh"]="none"
  CFG["SCRIPT:dmrun.sh"]="none"
  CFG["SCRIPT:lfrun.sh"]="none"
  CFG["SCRIPT:list.git-repos.diagnostic.sh"]="none"
  CFG["SCRIPT:misc.nvim-renaming.sh"]="none"
  CFG["SCRIPT:prompt.sh"]="none"
  CFG["SCRIPT:repo.info.sh"]="none"
  CFG["SCRIPT:screenshot.sh"]="none"
  CFG["SCRIPT:slock-cst.sh"]="none"
  CFG["SCRIPT:spectrWM-baraction.sh"]="none"
  CFG["SCRIPT:togkb.sh"]="none"
  CFG["SCRIPT:tr2md.sh"]="none"
  CFG["SCRIPT:upl.sh"]="none"
  CFG["SCRIPT:wvenv.sh"]="none"
  CFG["SCRIPT:xtcl.sh"]="none"
  CFG["SCRIPT:ytdl.sh"]="none"

  CFG["CONFIG:git"]="none"
  CFG["CONFIG:htop"]="none"
  CFG["CONFIG:bash"]="none"
  CFG["CONFIG:fish"]="none"
  CFG["CONFIG:zsh"]="none"
  CFG["CONFIG:starship"]="none"
  CFG["CONFIG:neofetch"]="none"
  CFG["CONFIG:vim"]="none"
  CFG["CONFIG:neovim"]="none"
  CFG["CONFIG:x"]="none"
  CFG["CONFIG:bspwm"]="none"
  CFG["CONFIG:spectrwm"]="none"
  CFG["CONFIG:alacritty"]="none"
  CFG["CONFIG:kitty"]="none"
  CFG["CONFIG:nitrogen"]="none"
  CFG["CONFIG:slock"]="none"
  CFG["CONFIG:xscreensaver"]="none"
  CFG["CONFIG:polybar"]="none"
  CFG["CONFIG:vifm"]="none"
  CFG["CONFIG:lf"]="none"
  CFG["CONFIG:surf"]="none"
  CFG["CONFIG:tabbed"]="none"
  CFG["CONFIG:wallpapers"]="none"
  CFG["CONFIG:dmenu"]="none"
  CFG["CONFIG:dmscripts"]="none"
  CFG["CONFIG:lazygit"]="none"
  CFG["CONFIG:tigrc"]="none"
  CFG["CONFIG:tmux"]="none"
  CFG["CONFIG:mpd"]="none"
  CFG["CONFIG:mpv"]="none"
  CFG["CONFIG:ncmpcpp"]="none"
}


install () {
  echo "$Normal ${Cmd}install ${Src}$1${Off}"; 
  case $1 in
    CONFIG:*) install_$(echo $1 | sed 's/CONFIG://');;
    REPO:*)   install_repo $(echo $1 | sed 's/REPO://');;
    SCRIPT:*) install_script $(echo $1 | sed 's/SCRIPT://');;
    FONT:*)   install_font $(echo $1 | sed 's/FONT://');;
    *)        echo "$Warning Unknown argument ${Cyn}$arg${Off}";;
  esac
}

restore () {
  echo "$Warning restore process NOT IMPLEMENTED YET, stay tuned."
}

################################################################################################
## main ########################################################################################
################################################################################################
main() {
	cat <<- EOF
$Normal Installing config...${Src}
  source: $DIR${Dst}
  destination: $HDIR${Off}

EOF

  echo "$Warning Prepairing backup:"
  if [[ ! -d "$DIR/old" ]]; then
    echo "${Wrn}mkdir -p $DIR/old${Off}"
    mkdir -p $DIR/old
  fi
  if [[ ! -d "$DIR/old/.config" ]]; then
    echo "${Wrn}mkdir -p $DIR/old/.config${Off}"
    mkdir -p $DIR/old/.config
  fi
	if [[ -d "$HDIR/$SDIR" ]]; then
		echo "${Wrn}mkdir -p $DIR/old/$SDIR${Off}"
		mkdir -p $DIR/old/$SDIR
	else
		echo "${Wrn}$HDIR/$SDIR does not exist${Off}"
		echo "${Wrn}mkdir -p $HDIR/$SDIR${Off}"
		mkdir -p $HDIR/$SDIR
	fi
  for cfg in $(cat $tmpfile | grep -v "^\s*#" | grep -v "^\s*$" | grep -v "^discard" | sed 's/^/"/; s/$/"/; s/ /-/'); do
    cmd=$(echo $cfg | sed 's/"//g; s/-/ /' | awk '{print $1}')
    arg=$(echo $cfg | sed 's/"//g; s/-/ /' | awk '{print $2}')
    case $cmd in
      install|i|inst|add|deploy|test) install $arg ;;
      restore|remove|rm|delete|del|r) restore $arg ;;
      *)                              echo "$Warning Unknown command ${Pkg}$cmd${Off} for ${Cyn}$arg${Off}";;
    esac
  done
  echo -e "\n$Normal Bye bye!!"
}

################################################################################################
## define and parse the flags and arguments ####################################################
################################################################################################
declare -A CFG
init_CFG
while [[ $# -gt 0 ]]; do
  case "$1" in
    +prog/sketchbook/FastLED-basics|+prog/scsc/fil-rouge|+prog/scsc/fgk|+prog/swarm-rescue-g1|+sup/tatami|+sup/machine-learning|+sup/imgDesc|+sup/flatland-project|+sup/deep-learning|+sup/stochastic|+sup/mcdm|+surf|+yay-git|+polybar|+lazycli|+dmscripts|+dmenu|+tabbed|+slock|+bash-insulter|+kitty|+Neovim-from-scratch|+oh-my-bash|+uzbl|+oh-my-fish|+a2n-s|+wallpapers|+oh-my-zsh|+sites/nereuxofficial.github.io|+sites/a2n-s.github.io/themes/hugo-theme-terminal|+sites/a2n-s.github.io|+dotfiles/atxr_dotfiles|+research/playground_env|+research/Imagine|+research/imagineXdial|+research/gym_ma_toy|+research/learning-to-communicate-pytorch) CFG["REPO:$(echo $1 | sed 's/^+//')"]="install";;
    -prog/sketchbook/FastLED-basics|-prog/scsc/fil-rouge|-prog/scsc/fgk|-prog/swarm-rescue-g1|-sup/tatami|-sup/machine-learning|-sup/imgDesc|-sup/flatland-project|-sup/deep-learning|-sup/stochastic|-sup/mcdm|-surf|-yay-git|-polybar|-lazycli|-dmscripts|-dmenu|-tabbed|-slock|-bash-insulter|-kitty|-Neovim-from-scratch|-oh-my-bash|-uzbl|-oh-my-fish|-a2n-s|-wallpapers|-oh-my-zsh|-sites/nereuxofficial.github.io|-sites/a2n-s.github.io/themes/hugo-theme-terminal|-sites/a2n-s.github.io|-dotfiles/atxr_dotfiles|-research/playground_env|-research/Imagine|-research/imagineXdial|-research/gym_ma_toy|-research/learning-to-communicate-pytorch) CFG["REPO:$(echo $1 | sed 's/^-//')"]="restore";;
    +_countdown.sh|+_parse_git_info.sh|+_shortwd.sh|+_stopwatch.sh|+dmrun.sh|+lfrun.sh|+list.git-repos.diagnostic.sh|+misc.nvim-renaming.sh|+prompt.sh|+repo.info.sh|+screenshot.sh|+slock-cst.sh|+spectrWM-baraction.sh|+togkb.sh|+tr2md.sh|+upl.sh|+wvenv.sh|+xtcl.sh|+ytdl.sh) CFG["SCRIPT:$(echo $1 | sed 's/^+//')"]="install";;
    -_countdown.sh|-_parse_git_info.sh|-_shortwd.sh|-_stopwatch.sh|-dmrun.sh|-lfrun.sh|-list.git-repos.diagnostic.sh|-misc.nvim-renaming.sh|-prompt.sh|-repo.info.sh|-screenshot.sh|-slock-cst.sh|-spectrWM-baraction.sh|-togkb.sh|-tr2md.sh|-upl.sh|-wvenv.sh|-xtcl.sh|-ytdl.sh) CFG["SCRIPT:$(echo $1 | sed 's/^-//')"]="restore";;
    +git|+htop|+bash|+fish|+zsh|+starship|+neofetch|+vim|+neovim|+x|+bspwm|+spectrwm|+alacritty|+kitty|+nitrogen|+slock|+xscreensaver|+polybar|+vifm|+lf|+surf|+tabbed|+wallpapers|+dmenu|+dmscripts|+lazygit|+tigrc|+tmux|+mpd|+mpv|+ncmpcpp) CFG["CONFIG:$(echo $1 | sed 's/^+//')"]="install";;
    -git|-htop|-bash|-fish|-zsh|-starship|-neofetch|-vim|-neovim|-x|-bspwm|-spectrwm|-alacritty|-kitty|-nitrogen|-slock|-xscreensaver|-polybar|-vifm|-lf|-surf|-tabbed|-wallpapers|-dmenu|-dmscripts|-lazygit|-tigrc|-tmux|-mpd|-mpv|-ncmpcpp) CFG["CONFIG:$(echo $1 | sed 's/^-//')"]="restore";;
    -h|--help)
cat -e | less <<- EOF
NAME
       ./install.sh - installs/removes interactively the config of a2n-s on your arch machine.

SYNOPSIS
       ./install.sh -cfgToRemove_1 -cfgToRemove_2 +cfgToInstall_1 +cfgToInstall_2 -cfgToRemove_3 ...

DESCRIPTION
       This is my install script.
       One installs a snippet of my config with '+name-of-config-to-install' or removes one with '-name-of-config-to-remove'.
       Note the use of '-' to remove stuff and '+' to indicate that the config should be installed.
       Flags are here as preselections only. A popup editor will always open and let you modify the preferences for the installation process. The script tries to open \$VISUAL, then \$EDITOR and finally falls back to \`vi\` in case any of the previous two has been found.

       There are four categories of config that one might find in my config files, with their particularities:
         - REPOS:
              They get installed, i.e. cloned in the \`\$HDIR/\$RDIR\` directory. The path is given in the flag name, e.g. the repo for my personal website in located at \`~/repos/sites\` under the name of \`a2n-s.github.io\`, thus the path is \`sites/a2n-s.github.io\`. Finally once the repo has been pulled, the origin should point towards my github account and the upstream is also set to reflect original forks.
              If the repo already exists on your machine, the install will prompt you to backup it and then retry.
  
         - SCRIPTS:
              All the scripts I use, the chosen ones will be installed under \`\$HDIR/\$SDIR\`.
              Your scripts, if in conflict with mine, will be backed up in \`\$DIR/old/\$SDIR\` to be recovered later.

         - CONFIG FILES:
              The config files I use. They will be installed either under \`\$HDIR\` or \`\$HDIR/\$CDIR\`.
              Your config files, if in conflict with mine, will be backed up in \`\$DIR/old\` or \`\$DIR/old/\$CDIR\` to be recovered later.

         - FONTS:
              coming soon...

OPTIONS
       -h, --help
           Display this help message and exits without installing nor removing anything.

      Below one can find the list of all the config one can install:
        REPOS:
          +/-prog/sketchbook/FastLED-basics
          +/-prog/scsc/fil-rouge
          +/-prog/scsc/fgk
          +/-prog/swarm-rescue-g1
          +/-sup/tatami
          +/-sup/machine-learning
          +/-sup/imgDesc
          +/-sup/flatland-project
          +/-sup/deep-learning
          +/-sup/stochastic
          +/-sup/mcdm
          +/-surf
          +/-yay-git
          +/-polybar
          +/-lazycli
          +/-dmscripts
          +/-dmenu
          +/-tabbed
          +/-slock
          +/-bash-insulter
          +/-kitty
          +/-Neovim-from-scratch
          +/-oh-my-bash
          +/-uzbl
          +/-oh-my-fish
          +/-a2n-s
          +/-wallpapers
          +/-oh-my-zsh
          +/-sites/nereuxofficial.github.io
          +/-sites/a2n-s.github.io/themes/hugo-theme-terminal
          +/-sites/a2n-s.github.io
          +/-dotfiles/atxr_dotfiles
          +/-research/playground_env
          +/-research/Imagine
          +/-research/imagineXdial
          +/-research/gym_ma_toy
          +/-research/learning-to-communicate-pytorch

        SCRIPTS:
          +/-_countdown.sh
          +/-_parse_git_info.sh
          +/-_shortwd.sh
          +/-_stopwatch.sh
          +/-dmrun.sh
          +/-lfrun.sh
          +/-list.git-repos.diagnostic.sh
          +/-misc.nvim-renaming.sh
          +/-prompt.sh
          +/-repo.info.sh
          +/-screenshot.sh
          +/-slock-cst.sh
          +/-spectrWM-baraction.sh
          +/-togkb.sh
          +/-tr2md.sh
          +/-upl.sh
          +/-wvenv.sh
          +/-xtcl.sh
          +/-ytdl.sh

        MISCELLANEOUS CONFIG FILES:
          +/-git
          +/-htop
          +/-bash
          +/-fish
          +/-zsh
          +/-starship
          +/-neofetch
          +/-vim
          +/-neovim
          +/-x
          +/-bspwm
          +/-spectrwm
          +/-alacritty
          +/-kitty
          +/-nitrogen
          +/-slock
          +/-xscreensaver
          +/-polybar
          +/-vifm
          +/-lf
          +/-surf
          +/-tabbed
          +/-wallpapers
          +/-dmenu
          +/-dmscripts
          +/-lazygit
          +/-tigrc
          +/-tmux
          +/-mpd
          +/-mpv
          +/-ncmpcpp

        FONTS:
          coming soon...

ENVIRONMENT
       DIR  = directory where the config has been pulled, computed with pwd by install.sh
       HDIR = \$HOME
       CDIR = .config
       SDIR = scripts
       RDIR = repos

EXAMPLES
       \`./install.sh +bash -fish +bspwm +neovim +git\` will install \`bash\`, \`bspwm\`, \`neovim\` and \`git\` and remove \`fish\` to and from your config.
       An editor will always popup to let you change the behaviour, but the config snippets above will be already preselected.

AUTHOR
       More about me and my config below:
       
         my personal page: https://a2n-s.github.io/
         my github   page: https://github.com/a2n-s
         my      dotfiles: https://github.com/a2n-s/dotfiles

REPORTING BUGS
       For bug reports, use the issue tracker at https://github.com/a2n-s/dotfiles/issues.

                                         $(display_center 2021-12-30)
EOF
exit
      ;;
    -*|+*)
      echo -e "$Error Unknown flag ${Pkg}$1${Off}"
      exit 2
      ;;
    *)
      echo -e "$Error Not even a flag (${Pkg}$1${Off})"
      exit 2
      ;;
  esac
  shift
done

################################################################################################
## open up configuration interactive file ######################################################
################################################################################################
# build file #
##############
tmpfile=$(mktemp /tmp/a2n-s.install.XXXXXX)
trap  'rm "$tmpfile"' 0 1 15
cat << EOF > "$tmpfile"
# Every line beginning with a '#' will be treated as a comment and thus discarded.

EOF
for cfg in "${!CFG[@]}"; do
    if [[ ! "${CFG[$cfg]}" =~ "none" ]]; then
      echo "${CFG[$cfg]} $cfg" | sed 's/^none/discard/' >> $tmpfile
    fi
done
cat << EOF >> "$tmpfile"

# Commands:
# i, install <config>   | install the config.
# r, restore <config>   | restore the config.
# d, discard <config>   | discard the config, same as commenting or deleting the line.
# n, none <config>      | don't do anything with the config, same as commenting or deleting the line.

EOF
for cfg in "${!CFG[@]}"; do
    if [[ "${CFG[$cfg]}" =~ "none" ]]; then
      echo "${CFG[$cfg]} $cfg" | sed 's/^none/discard/' >> $tmpfile
    fi
done

#############
# open file #
#############
if [[ -n $VISUAL ]]; then
  $VISUAL $tmpfile
elif [[ -n $EDITOR ]]; then
  $EDITOR $tmpfile
else
  vi $tmpfile
fi

main
