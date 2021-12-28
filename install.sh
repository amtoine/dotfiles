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
repos+=(".config/nvim git@github.com:a2n-s/neovim.git ")
repos+=("prog/sketchbook/FastLED-basics git@github.com:s-marley/FastLED-basics.git ")
repos+=("prog/scsc/fil-rouge git@github.com:a2n-s/fil-rouge.git git@github.com:iScsc/fil-rouge.git")
repos+=("prog/scsc/fgk git@github.com:a2n-s/fgk.git ")
repos+=("prog/swarm-rescue-g1 git@github.com:a2n-s/swarm-rescue-g1.git git@github.com:atxr/swarm-rescue-g1.git")
repos+=("sup/tatami https://github.com/a2n-s/tatami.git ")
repos+=("sup/machine-learning git@github.com:a2n-s/machine-learning.git git@github.com:SupaeroDataScience/machine-learning.git")
repos+=("sup/imgDesc git@github.com:a2n-s/imgDesc.git ")
repos+=("sup/flatland-project git@github.com:abfariah/flatland-project.git https://github.com/SupaeroDataScience/flatland-project")
repos+=("sup/deep-learning git@github.com:a2n-s/deep-learning.git git@github.com:SupaeroDataScience/deep-learning.git")
repos+=("sup/neuraltalk2 git@github.com:karpathy/neuraltalk2.git ")
repos+=("sup/stochastic git@github.com:a2n-s/stochastic.git https://github.com/SupaeroDataScience/stochastic.git")
repos+=("sup/mcdm git@github.com:a2n-s/mcdm.git ")
repos+=("repos/surf git@github.com:a2n-s/surf.git git://git.suckless.org/surf")
repos+=("repos/yay-git https://aur.archlinux.org/yay-git.git ")
repos+=("repos/polybar git@github.com:a2n-s/polybar-themes.git git@github.com:adi1090x/polybar-themes.git")
repos+=("repos/lazycli git@github.com:jesseduffield/lazycli.git ")
repos+=("repos/dmscripts git@github.com:a2n-s/dmscripts.git https://gitlab.com/dwt1/dmscripts.git")
repos+=("repos/dmenu git@github.com:a2n-s/dmenu.git git://git.suckless.org/dmenu")
repos+=("repos/tabbed git@github.com:a2n-s/tabbed.git git://git.suckless.org/tabbed")
repos+=("repos/slock git@github.com:a2n-s/slock.git https://git.suckless.org/slock")
repos+=("repos/bash-insulter git@github.com:a2n-s/bash-insulter.git ")
repos+=("repos/kitty git@github.com:a2n-s/kitty.git git@github.com:kovidgoyal/kitty.git")
repos+=("repos/Neovim-from-scratch git@github.com:LunarVim/Neovim-from-scratch.git ")
repos+=("repos/oh-my-bash git@github.com:a2n-s/oh-my-bash.git git@github.com:ohmybash/oh-my-bash.git")
repos+=("repos/uzbl git://github.com/uzbl/uzbl.git ")
repos+=("repos/oh-my-fish git@github.com:a2n-s/oh-my-fish.git git@github.com:oh-my-fish/oh-my-fish.git")
repos+=("repos/a2n-s git@github.com:a2n-s/a2n-s.git ")
repos+=("repos/wallpapers git@github.com:a2n-s/wallpapers.git ")
repos+=("repos/oh-my-zsh git@github.com:a2n-s/ohmyzsh.git git@github.com:ohmyzsh/ohmyzsh.git")
repos+=("repos/sites/nereuxofficial.github.io git@github.com:Nereuxofficial/nereuxofficial.github.io.git ")
repos+=("repos/sites/a2n-s.github.io/themes/hugo-theme-terminal git@github.com:a2n-s/hugo-theme-terminal.git git@github.com:panr/hugo-theme-terminal.git")
repos+=("repos/sites/a2n-s.github.io git@github.com:a2n-s/a2n-s.github.io.git ")
repos+=("repos/dotfiles/atxr_dotfiles https://github.com/atxr/dotfiles.git ")
repos+=("research/playground_env git@github.com:flowersteam/playground_env.git ")
repos+=("research/Imagine https://github.com/flowersteam/Imagine.git ")
repos+=("research/imagineXdial https://github.com/SuReLI/imagineXdial.git ")
repos+=("research/gym_ma_toy https://github.com/MehdiZouitine/gym_ma_toy ")
repos+=("research/learning-to-communicate-pytorch https://github.com/minqi/learning-to-communicate-pytorch.git ")

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
        read -p "[?] ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
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
        read -p "[?] ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
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
	echo -e "\n[*] Installing files..."
  for file in ${files[@]}; do
    if [[ -f "$HDIR/$file" ]]; then
      echo "$HDIR/$file already exists"
      if [[ -f "$DIR/old/$file" ]]; then
        read -p "[?] ${Crt}backup already exists...${Off} [1|o] Override backup. [2|k] Keep backup file. "
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
  for repo in "${repos[@]}"; do
    r_path=$(echo $repo | awk '{print $1}')
    r_orig=$(echo $repo | awk '{print $2}')
    r_upst=$(echo $repo | awk '{print $3}')
    echo "$r_path"
    echo "     origin: $r_orig"
    [[ $r_upst != "" ]] && echo "     upstream: $r_upst"
    echo
  done
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

install () {
  if [[ ! -d "$HDIR/old" ]]; then
    echo "${Wrn}mkdir -p $DIR/old${Off}"
    mkdir -p $DIR/old
  fi
  if [[ ! -d "$HDIR/old/.config" ]]; then
    echo "${Wrn}mkdir -p $DIR/old/.config${Off}"
    mkdir -p $DIR/old/.config
  fi
  prompt_for_install_and_install "install_scripts" "scripts"
  prompt_for_install_and_install "install_configs" "directories and standalone files"
  # prompt_for_install_and_install "install_fonts"   "fonts"
  # prompt_for_install_and_install "install_repos"   "repos"
}

main() {
	clear

	cat <<- EOF
		[*] Installing config...
    source: $DIR
    destination: $HDIR

	EOF
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
  exit 0

  # install

  echo -e "\nBye bye!!"
}

main
