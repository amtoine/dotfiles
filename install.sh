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

# Reset
Off=$(printf '\033[0m')             # Text Reset
# Regular Colors
Blk=$(printf '\033[0;30m')          # Black
Red=$(printf '\033[0;31m')          # Red
Grn=$(printf '\033[0;32m')          # Green
Ylw=$(printf '\033[0;33m')          # Yellow
Blu=$(printf '\033[0;34m')          # Blue
Pur=$(printf '\033[0;35m')          # Purple
Cyn=$(printf '\033[0;36m')          # Cyan
Wht=$(printf '\033[0;37m')          # White
# Bold
BBlack=$(printf '\033[1;30m')       # Black
BRed=$(printf '\033[1;31m')         # Red
BGreen=$(printf '\033[1;32m')       # Green
BYellow=$(printf '\033[1;33m')      # Yellow
BBlue=$(printf '\033[1;34m')        # Blue
BPurple=$(printf '\033[1;35m')      # Purple
BCyan=$(printf '\033[1;36m')        # Cyan
BWhite=$(printf '\033[1;37m')       # White
# Underline
UBlack=$(printf '\033[4;30m')       # Black
URed=$(printf '\033[4;31m')         # Red
UGreen=$(printf '\033[4;32m')       # Green
UYellow=$(printf '\033[4;33m')      # Yellow
UBlue=$(printf '\033[4;34m')        # Blue
UPurple=$(printf '\033[4;35m')      # Purple
UCyan=$(printf '\033[4;36m')        # Cyan
UWhite=$(printf '\033[4;37m')       # White
# Background
On_Black=$(printf '\033[40m')       # Black
On_Red=$(printf '\033[41m')         # Red
On_Green=$(printf '\033[42m')       # Green
On_Yellow=$(printf '\033[43m')      # Yellow
On_Blue=$(printf '\033[44m')        # Blue
On_Purple=$(printf '\033[45m')      # Purple
On_Cyan=$(printf '\033[46m')        # Cyan
On_White=$(printf '\033[47m')       # White
# High Intensity
IBlack=$(printf '\033[0;90m')       # Black
IRed=$(printf '\033[0;91m')         # Red
IGreen=$(printf '\033[0;92m')       # Green
IYellow=$(printf '\033[0;93m')      # Yellow
IBlue=$(printf '\033[0;94m')        # Blue
IPurple=$(printf '\033[0;95m')      # Purple
ICyan=$(printf '\033[0;96m')        # Cyan
IWhite=$(printf '\033[0;97m')       # White
# Bold High Intensity
BIBlack=$(printf '\033[1;90m')      # Black
BIRed=$(printf '\033[1;91m')        # Red
BIGreen=$(printf '\033[1;92m')      # Green
BIYellow=$(printf '\033[1;93m')     # Yellow
BIBlue=$(printf '\033[1;94m')       # Blue
BIPurple=$(printf '\033[1;95m')     # Purple
BICyan=$(printf '\033[1;96m')       # Cyan
BIWhite=$(printf '\033[1;97m')      # White
# High Intensity backgrounds
On_IBlack=$(printf '\033[0;100m')   # Black
On_IRed=$(printf '\033[0;101m')     # Red
On_IGreen=$(printf '\033[0;102m')   # Green
On_IYellow=$(printf '\033[0;103m')  # Yellow
On_IBlue=$(printf '\033[0;104m')    # Blue
On_IPurple=$(printf '\033[0;105m')  # Purple
On_ICyan=$(printf '\033[0;106m')    # Cyan
On_IWhite=$(printf '\033[0;107m')   # White

# Specific color use.
Err=$Red
Wrn=$Ylw
Crt=$Red
Cmd=$Blu
Src=$Pur
Dst=$Grn

# ".gitconfig"
# sudo pacman -Syu git
#
# ".config/htop"
# sudo pacman -Syu htop
#
# ".bash_logout"
# ".bash_profile"
# ".bashrc"
# ".profile"
# sudo pacman -Syu nvim git ponysay fortune starship
# git clone git://github.com/a2n-s/oh-my-bash.git ~/repos/oh-my-bash
# sudo wget -O /etc/bash.command-not-found https://raw.githubusercontent.com/hkbakke/bash-insulter/master/src/bash.command-not-found
# pip install virtualenvwrapper
# yay -S shell-color-scripts
#
# ".config/starship.toml"
# yay -S nerd-fonts-mononoki
# sudo pacman -Syu starship
#
# ".config/neofetch"
# sudo pacman -Syu neofetch pr
#
# ".vimrc"
# sudo pacman -Syu vim
# mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/color ~/.vim/plugged
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# curl -fLo ~/.vim/colors/molokai.vim --create-dirs https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
# # run :PlugInstall in vim
#
# sudo pacman -Syu nvim
# git clone https://github.com/a2n-s/neovim ~/.config/nvim
# # backup your plugins ans LSP servers
# # run nvim at least once to install plugins.
# # run :LSPInstallInfo to install language server protocols for your completion
#
# ".xinitrc"
# sudo pacman -Syu xorg picom
#
# ".config/bspwm"
# ".config/sxhkd"
# sudo pacman -Syu bspwm feh
# sudo pacman -Syu sxhkd
#
#
# ".config/spectrwm"
# sudo pacman -Syu spectrwm
#
# ".config/alacritty"
# yay -S nerd-fonts-mononoki
# sudo pacman -Syu alacritty
#
# ".config/kitty"
# git clone https://github.com/a2n-s/kitty ~/repos/kitty
# cd ~/repos/kitty
# git checkout main
# make
# ln -s ./kitty/launcher/kitty /usr/bin/kitty
#
# ".config/nitrogen"
# sudo pacman -Syu nitrogen
#
# git clone https://github.com/a2n-s/slock ~/repos/slock
# cd ~/repos/slock
# git checkout main
# make clean install
#
# ".xscreensaver"
# sudo pacman -Syu xscreensaver
#
# sudo pacman -Syu polybar
# git clone --depth=1 https://github.com/a2n-s/polybar-themes.git ~/repos/polybar
# chmod +x ~/repos/polybar/setup.sh
# ~/repos/polybar/setup.sh
#
# ".config/vifm"
# sudo pacman -Syu vifm
#
# ".tmux.conf"
# sudo pacman -Syu tmux
#
# ".config/surf"
# git clone https://github.com/a2n-s/surf ~/repos/surf
# cd ~/repos/surf
# git checkout main
# make clean install
#
# git clone https://github.com/a2n-s/tabbed ~/repos/tabbed
# cd ~/repos/tabbed
# git checkout main
# make clean install
#
# git clone https://github.com/a2n-s/wallpaper ~/repos/wallpapers
#
# git clone https://github.com/a2n-s/dmenu ~/repos/dmenu
# cd ~/repos/dmenu
# git checkout main
# make clean install
#
# ".config/dmscripts"
# git clone https://github.com/a2n-s/dmscripts ~/repos/dmscripts
#
# ".config/fish"
# sudo pacman -Syu fish
# git clone git://github.com/a2n-s/oh-my-fish.git ~/repos/oh-my-fish
#
# ".config/lazygit"
# sudo pacman -Syu lazygit
#
# ".config/lf"
# yay -S lf
#
# ".config/mpd"
# sudo pacman -Syu mpd
#
# ".config/mpv"
# sudo pacman -Syu mpv
#
# ".config/ncmpcpp"
# sudo pacman -Syu ncmpcpp
#
# ".config/tigrc"
# sudo pacman -Syu tig
#
# ".zshrc"
# sudo pacman -Syu zsh
# git clone git://github.com/a2n-s/ohmyzsh.git ~/repos/oh-my-zsh


# for repo in ${repos[@]}; do
#   git -C $repo rmtv | sed 's/.*\s\+\(.*\)\s\+.*/\1/' | uniq
# done
repositories=()
# repositories+=(".config/nvim git@github.com:a2n-s/neovim.git ")
# repositories+=("prog/sketchbook/FastLED-basics git@github.com:s-marley/FastLED-basics.git ")
repositories+=("prog/scsc/fil-rouge git@github.com:a2n-s/fil-rouge.git git@github.com:iScsc/fil-rouge.git")
repositories+=("prog/scsc/fgk git@github.com:a2n-s/fgk.git ")
# repositories+=("prog/swarm-rescue-g1 git@github.com:a2n-s/swarm-rescue-g1.git git@github.com:atxr/swarm-rescue-g1.git")
# repositories+=("sup/tatami https://github.com/a2n-s/tatami.git ")
# repositories+=("sup/machine-learning git@github.com:a2n-s/machine-learning.git git@github.com:SupaeroDataScience/machine-learning.git")
# repositories+=("sup/imgDesc git@github.com:a2n-s/imgDesc.git ")
# repositories+=("sup/flatland-project git@github.com:abfariah/flatland-project.git https://github.com/SupaeroDataScience/flatland-project")
# repositories+=("sup/deep-learning git@github.com:a2n-s/deep-learning.git git@github.com:SupaeroDataScience/deep-learning.git")
# repositories+=("sup/neuraltalk2 git@github.com:karpathy/neuraltalk2.git ")
# repositories+=("sup/stochastic git@github.com:a2n-s/stochastic.git https://github.com/SupaeroDataScience/stochastic.git")
# repositories+=("sup/mcdm git@github.com:a2n-s/mcdm.git ")
# repositories+=("repos/surf git@github.com:a2n-s/surf.git git://git.suckless.org/surf")
# repositories+=("repos/yay-git https://aur.archlinux.org/yay-git.git ")
# repositories+=("repos/polybar git@github.com:a2n-s/polybar-themes.git git@github.com:adi1090x/polybar-themes.git")
# repositories+=("repos/lazycli git@github.com:jesseduffield/lazycli.git ")
# repositories+=("repos/dmscripts git@github.com:a2n-s/dmscripts.git https://gitlab.com/dwt1/dmscripts.git")
# repositories+=("repos/dmenu git@github.com:a2n-s/dmenu.git git://git.suckless.org/dmenu")
# repositories+=("repos/tabbed git@github.com:a2n-s/tabbed.git git://git.suckless.org/tabbed")
# repositories+=("repos/slock git@github.com:a2n-s/slock.git https://git.suckless.org/slock")
# repositories+=("repos/bash-insulter git@github.com:a2n-s/bash-insulter.git ")
# repositories+=("repos/kitty git@github.com:a2n-s/kitty.git git@github.com:kovidgoyal/kitty.git")
# repositories+=("repos/Neovim-from-scratch git@github.com:LunarVim/Neovim-from-scratch.git ")
# repositories+=("repos/oh-my-bash git@github.com:a2n-s/oh-my-bash.git git@github.com:ohmybash/oh-my-bash.git")
# repositories+=("repos/uzbl git://github.com/uzbl/uzbl.git ")
# repositories+=("repos/oh-my-fish git@github.com:a2n-s/oh-my-fish.git git@github.com:oh-my-fish/oh-my-fish.git")
# repositories+=("repos/a2n-s git@github.com:a2n-s/a2n-s.git ")
# repositories+=("repos/wallpapers git@github.com:a2n-s/wallpapers.git ")
# repositories+=("repos/oh-my-zsh git@github.com:a2n-s/ohmyzsh.git git@github.com:ohmyzsh/ohmyzsh.git")
# repositories+=("repos/sites/nereuxofficial.github.io git@github.com:Nereuxofficial/nereuxofficial.github.io.git ")
# repositories+=("repos/sites/a2n-s.github.io/themes/hugo-theme-terminal git@github.com:a2n-s/hugo-theme-terminal.git git@github.com:panr/hugo-theme-terminal.git")
# repositories+=("repos/sites/a2n-s.github.io git@github.com:a2n-s/a2n-s.github.io.git ")
# repositories+=("repos/dotfiles/atxr_dotfiles https://github.com/atxr/dotfiles.git ")
# repositories+=("research/playground_env git@github.com:flowersteam/playground_env.git ")
# repositories+=("research/Imagine https://github.com/flowersteam/Imagine.git ")
# repositories+=("research/imagineXdial https://github.com/SuReLI/imagineXdial.git ")
# repositories+=("research/gym_ma_toy https://github.com/MehdiZouitine/gym_ma_toy ")
# repositories+=("research/learning-to-communicate-pytorch https://github.com/minqi/learning-to-communicate-pytorch.git ")

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

DIR=`pwd`
HDIR="$HOME/fake"
CDIR=".config"
SDIR="scripts"
RDIR="repos"

install_script() {
  if [[ -f "$HDIR/$SDIR/$1" ]]; then
    echo "$HDIR/$SDIR/$1 already exists"
    if [[ -f "$DIR/old/$SDIR/$1" ]]; then
      read -p "[?] ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
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
}
install_scripts() {
	echo -e "\n[*] Installing scripts..."
	if [[ -d "$HDIR/$SDIR" ]]; then
		echo "${Wrn}$HDIR/$SDIR exists, prepairing backup${Off}"
		echo "${Wrn}mkdir -p $DIR/old/$SDIR${Off}"
		mkdir -p $DIR/old/$SDIR
	else
		echo "${Wrn}$HDIR/$SDIR does not exist${Off}"
		echo "${Wrn}mkdir -p $HDIR/$SDIR${Off}"
		mkdir -p $HDIR/$SDIR
	fi
  for script in ${scripts[@]}; do
    install_script $script
  done
}

install_dir() {
  if [[ -d "$HDIR/$1" ]]; then
    echo "${Wrn}$HDIR/$1 already exists${Off}"
    if [[ -d "$DIR/old/$1" ]]; then
      read -p "[?] ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
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
      read -p "[?] ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup 1. "
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
install_configs() {
	echo -e "\n[*] Installing directories..."
  for directory in ${directories[@]}; do
    install_dir $directory
  done
	echo -e "\n[*] Installing files..."
  for file in ${files[@]}; do
    install_file $file
  done
}

install_repo() {
  if [[ -d $HDIR/$RDIR/$1 ]]; then
    echo "${Wrn}$HDIR/$RDIR/$1 already exists${Off}"
    echo "${Wrn}please backup $HDIR/$RDIR/$1 before trying again${Off}"
  else
    echo "${Crt}$HDIR/$RDIR/$1 does not exist${Off}"
    echo "${Wrn}mkdir -p $HDIR/$RDIR/$(dirname $1)${Off}"
    mkdir -p $HDIR/$RDIR/$(dirname $1)
    echo -e "${Crt}git clone ${Src}$2 ${Dst}$HDIR/$RDIR/$1${Off}"
    git clone $2 $HDIR/$RDIR/$1
    if [[ ! $3 == "" ]]; then
      echo -e "${Cmd}git -C ${Dst}$HDIR/$RDIR/$1 ${Cmd}remote add upstream ${Src}$3${Off}"
      git -C $HDIR/$RDIR/$1 remote add upstream $3
      echo -e "${Cmd}git -C ${Dst}$HDIR/$RDIR/$1 ${Cmd}fetch upstream --prune${Off}"
      git -C $HDIR/$RDIR/$1 fetch upstream --prune
    fi
  fi
}
install_repos() {
	echo -e "\n[*] Installing repos..."
  for repository in "${repositories[@]}"; do
    echo "repo: $repository"
    install_repo $repository
  done
}

install_font() {
	echo -ne "\n[*] Available soon..."
}
install_fonts() {
	echo -ne "\n[*] Installing fonts..."
	echo -ne "\n[*] Available soon..."
}

prompt_for_install_and_install() {
  echo ""
  read -p "[?] Install $2? (y/n/q) "
  case "$REPLY" in
    "y")  $1
    ;;
    "n")  echo "Skipping $2!"
    ;;
    "q")  echo "Aborting!"
          exit 1
    ;;
    *) echo -e "\n[!] Invalid Option, Skipping...\n"
    ;;
  esac
}

install () {
  if [[ ! -d "$DIR/old" ]]; then
    echo "${Wrn}mkdir -p $DIR/old${Off}"
    mkdir -p $DIR/old
  fi
  if [[ ! -d "$DIR/old/.config" ]]; then
    echo "${Wrn}mkdir -p $DIR/old/.config${Off}"
    mkdir -p $DIR/old/.config
  fi
  prompt_for_install_and_install "install_scripts" "scripts"
  # prompt_for_install_and_install "install_configs" "directories and standalone files"
  prompt_for_install_and_install "install_fonts"   "fonts"
  prompt_for_install_and_install "install_repos"   "repos"
}

main() {
	clear

	cat <<- EOF
		[*] Installing config...
    source: $DIR
    destination: $HDIR

		[*] Choose option-
		[1|o] Override everything.
		[2|m] Minimal install.
		[3|i] Interactive installation.
	EOF
  read -p "[?] What do you want the installation to be ? (1/2/3) "
  case "$REPLY" in
    1|"o") INST_MODE="override"
    ;;
    2|"m") INST_MODE="minimal"
    ;;
    3|"i") INST_MODE="interactive"
    ;;
    *) echo "defaulting..."
       INST_MODE="interactive"
    ;;
  esac
  echo "you choose the $INST_MODE mode"
  echo "                \`--> does not have any impact for now..."

  install

  echo -e "\nBye bye!!"
}

main
