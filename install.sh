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

directories=()
directories+=(".config/alacritty")
directories+=(".config/bspwm")
directories+=(".config/dmscripts")
directories+=(".config/fish")
directories+=(".config/htop")
directories+=(".config/kitty")
directories+=(".config/lazygit")
directories+=(".config/lf")
directories+=(".config/mpd")
directories+=(".config/mpv")
directories+=(".config/ncmpcpp")
directories+=(".config/neofetch")
directories+=(".config/nitrogen")
directories+=(".config/spectrwm")
directories+=(".config/surf")
directories+=(".config/sxhkd")
directories+=(".config/vifm")

files=()
files+=(".bash_logout")
files+=(".bash_profile")
files+=(".bashrc")
files+=(".config/starship.toml")
files+=(".config/tigrc")
files+=(".gitconfig")
files+=(".profile")
files+=(".tmux.conf")
files+=(".vimrc")
files+=(".xinitrc")
files+=(".xscreensaver")
files+=(".zshrc")

# for repo in ${repos[@]}; do
#   git -C $repo rmtv | sed 's/.*\s\+\(.*\)\s\+.*/\1/' | uniq
# done
repos=()
repos+=("/home/ants/.password-store")
repos+=("/home/ants/.config/nvim")
repos+=("/home/ants/prog/sketchbook/FastLED-basics")
repos+=("/home/ants/prog/scsc/fil-rouge")
repos+=("/home/ants/prog/scsc/fgk")
repos+=("/home/ants/prog/swarm-rescue-g1")
repos+=("/home/ants/sup/tatami")
repos+=("/home/ants/sup/machine-learning")
repos+=("/home/ants/sup/imgDesc")
repos+=("/home/ants/sup/flatland-project")
repos+=("/home/ants/sup/deep-learning")
repos+=("/home/ants/sup/stochastic")
repos+=("/home/ants/sup/mcdm")
repos+=("/home/ants/repos/surf")
repos+=("/home/ants/repos/yay-git")
repos+=("/home/ants/repos/polybar")
repos+=("/home/ants/repos/lazycli")
repos+=("/home/ants/repos/dmscripts")
repos+=("/home/ants/repos/dmenu")
repos+=("/home/ants/repos/tabbed")
repos+=("/home/ants/repos/slock")
repos+=("/home/ants/repos/bash-insulter")
repos+=("/home/ants/repos/kitty")
repos+=("/home/ants/repos/Neovim-from-scratch")
repos+=("/home/ants/repos/oh-my-bash")
repos+=("/home/ants/repos/uzbl")
repos+=("/home/ants/repos/oh-my-fish")
repos+=("/home/ants/repos/a2n-s")
repos+=("/home/ants/repos/wallpapers")
repos+=("/home/ants/repos/oh-my-zsh")
repos+=("/home/ants/repos/sites/nereuxofficial.github.io")
repos+=("/home/ants/repos/sites/a2n-s.github.io")
repos+=("/home/ants/repos/dotfiles/atxr_dotfiles")
repos+=("/home/ants/repos/dotfiles/dotfiles")
repos+=("/home/ants/research/playground_env")
repos+=("/home/ants/research/Imagine")
repos+=("/home/ants/research/imagineXdial")
repos+=("/home/ants/research/gym_ma_toy")
repos+=("/home/ants/research/learning-to-communicate-pytorch")

scripts=()
scripts+=("_countdown.sh")
scripts+=("_parse_git_info.sh")
scripts+=("_shortwd.sh")
scripts+=("_stopwatch.sh")
scripts+=("dmrun.sh")
scripts+=("lfrun.sh")
scripts+=("prompt.sh")
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
HDIR="${HOME}"
CDIR=".config"
SDIR="scripts"
RDIR="repos"

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
    if [[ -f "$HDIR/$SDIR/$script" ]]; then
      echo "$HDIR/$SDIR/$script already exists"
      if [[ -f "$DIR/old/$SDIR/$script" ]]; then
        read -p "[*] ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
        case "$REPLY" in
          1|"o")  echo "${Crt}mv ${Src}$HDIR/$SDIR/$script ${Dst}$DIR/old/$SDIR/$script${Off}"
	              	mv $HDIR/$SDIR/$script $DIR/old/$SDIR/$script
          ;;
          2|"k")  echo "${Wrn}Keeping previous backup file.${Off}"
          ;;
          *) echo "${Wrn}Keeping previous backup file.${Off}"
          ;;
        esac
      else
	     	echo "${Crt}mv ${Src}$HDIR/$SDIR/$script ${Dst}$DIR/old/$SDIR/$script${Off}"
	     	mv $HDIR/$SDIR/$script $DIR/old/$SDIR/$script
      fi
      echo "${Cmd}cp -rf ${Src}$DIR/$SDIR/$script ${Dst}$HDIR/$SDIR/$script${Off}"
      cp -rf $DIR/$SDIR/$script $HDIR/$SDIR/$script
    else
      echo "${Cmd}cp -rf ${Src}$DIR/$SDIR/$script ${Dst}$HDIR/$SDIR/$script${Off}"
      cp -rf $DIR/$SDIR/$script $HDIR/$SDIR/$script
    fi
  done
}
install_configs() {
	echo -e "\n[*] Installing directories..."
  for directory in ${directories[@]}; do
    if [[ -d "$HDIR/$directory" ]]; then
      echo "${Wrn}$HDIR/$directory already exists${Off}"
      if [[ -d "$DIR/old/$directory" ]]; then
        read -p "[*] ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
        case "$REPLY" in
          1|"o")  echo "${Crt}mv ${Src}$HDIR/$directory/* ${Dst}$DIR/old/$directory${Off}"
                  mv $HDIR/$directory/* $DIR/old/$directory
          ;;
          2|"k")  echo "${Wrn}Keeping previous backup file.${Off}"
          ;;
          *) echo "${Wrn}Keeping previous backup file.${Off}"
          ;;
        esac
      else
        echo "${Wrn}mkdir -p $DIR/old/$directory${Off}"
        mkdir -p $DIR/old/$directory
	     	echo "${Crt}mv ${Src}$HDIR/$directory/* ${Dst}$DIR/old/$directory${Off}"
	     	mv $HDIR/$directory/* $DIR/old/$directory
      fi
      echo "${Cmd}cp -rf ${Src}$DIR/$directory/* ${Dst}$HDIR/$directory${Off}"
      cp -rf $DIR/$directory/* $HDIR/$directory
    else
      echo "${Wrn}$HDIR/$directory does not exist${Off}"
      echo "${Wrn}mkdir -p $HDIR/$directory${Off}"
      mkdir -p $HDIR/$directory
      echo "${Cmd}cp -rf ${Src}$DIR/$directory/* ${Dst}$HDIR/$directory${Off}"
      cp -rf $DIR/$directory/* $HDIR/$directory
    fi
  done
	echo -ne "\n[*] Installing files..."
  for file in ${files[@]}; do
    if [[ -f "$HDIR/$file" ]]; then
      echo "$HDIR/$file already exists"
      if [[ -f "$DIR/old/$file" ]]; then
        read -p "[*] ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
        case "$REPLY" in
          1|"o")  echo "${Crt}mv ${Src}$HDIR/$file ${Dst}$DIR/old/$file${Off}"
	              	mv $HDIR/$file $DIR/old/$file
          ;;
          2|"k")  echo "${Wrn}Keeping previous backup file.${Off}"
          ;;
          *) echo "${Wrn}Keeping previous backup file.${Off}"
          ;;
        esac
      else
	     	echo "${Crt}mv ${Src}$HDIR/$file ${Dst}$DIR/old/$file${Off}"
	     	mv $HDIR/$file $DIR/old/$file
      fi
      echo "${Cmd}cp -rf ${Src}$DIR/$file ${Dst}$HDIR/$file${Off}"
      cp -rf $DIR/$file $HDIR/$file
    else
      echo "${Cmd}cp -rf ${Src}$DIR/$file ${Dst}$HDIR/$file${Off}"
      cp -rf $DIR/$file $HDIR/$file
    fi
  done
}
install_repos() {
	echo -ne "\n[*] Installing repos..."
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
    "n")  echo "Discarding installation of $2!"
    ;;
    "q")  echo "Aborting!"
          exit 1
    ;;
    *) echo -e "\n[!] Invalid Option, Skipping...\n"
    ;;
  esac
}

main() {
	clear

	cat <<- EOF
		[*] Installing config...
    source: $DIR
    destination: $HDIR

	EOF
	# 	[*] Choose option-
	# 	[1|o] Override everything.
	# 	[2|m] Minimal install.
	# 	[3|i] Interactive installation.
	# EOF
  # read -p "[?] What do you want the installation to be ? (1/2/3) "
  # case "$REPLY" in
  #   1|"o") INST_MODE="override"
  #   ;;
  #   2|"m") INST_MODE="minimal"
  #   ;;
  #   3|"i") INST_MODE="interactive"
  #   ;;
  #   *) echo "defaulting..."
  #      INST_MODE="interactive"
  #   ;;
  # esac
  # echo "you choose the $INST_MODE mode"
  # echo "                \`--> does not have any impact for now..."
  # exit 0

  if [[ ! -d "$HDIR/old" ]]; then
    echo "${Wrn}mkdir -p $DIR/old"
    mkdir -p $DIR/old
  fi
  if [[ ! -d "$HDIR/old/.config" ]]; then
    echo "${Wrn}mkdir -p $DIR/old/.config"
    mkdir -p $DIR/old/.config
  fi
  prompt_for_install_and_install "install_scripts" "scripts"
  prompt_for_install_and_install "install_configs" "directories and standalone files"
  # prompt_for_install_and_install "install_fonts"   "fonts"
  # prompt_for_install_and_install "install_repos"   "repos"

  echo -e "\nBye bye!!"
}

main
