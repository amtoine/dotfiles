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
Color_Off=$(printf '\033[0m')       # Text Reset

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

files=()
files+=(".bash_logout")
files+=(".bash_profile")
files+=(".bashrc")
files+=(".config/alacritty/alacritty.yml")
files+=(".config/bspwm/bspwmrc")
files+=(".config/bspwm/scheme.sh")
files+=(".config/dmscripts/config")
files+=(".config/fish/config.fish")
files+=(".config/fish/fish_variables")
files+=(".config/fish/functions/fish_greeting.fish")
files+=(".config/fish/functions/on_exit.fish")
files+=(".config/htop/htoprc")
files+=(".config/kitty/kitty.conf")
files+=(".config/lazygit/config.yml")
files+=(".config/lazygit/state.yml")
files+=(".config/lf/lfrc")
files+=(".config/lf/scripts/cleaner.sh")
files+=(".config/lf/scripts/previewer.sh")
files+=(".config/mpd/mpd.conf")
files+=(".config/mpv/input.conf")
files+=(".config/mpv/mplayer-input.conf")
files+=(".config/mpv/mpv.conf")
files+=(".config/mpv/restore-old-bindings.conf")
files+=(".config/ncmpcpp/config")
files+=(".config/neofetch/ascii/christmas.art")
files+=(".config/neofetch/ascii/fall-leaf.art")
files+=(".config/neofetch/ascii/halloween.art")
files+=(".config/neofetch/ascii/lolo.art")
files+=(".config/neofetch/ascii/spring-flower.art")
files+=(".config/neofetch/ascii/summer-sun.art")
files+=(".config/neofetch/ascii/winter-snow.art")
files+=(".config/neofetch/config.conf")
files+=(".config/neofetch/neofetchrc")
files+=(".config/nitrogen/nitrogen.cfg")
files+=(".config/spectrwm/spectrwm.conf")
files+=(".config/spectrwm/spectrwm_fr.conf")
files+=(".config/spectrwm/spectrwm_us.conf")
files+=(".config/starship.toml")
files+=(".config/surf/bookmarks")
files+=(".config/surf/html/homepage.html")
files+=(".config/surf/scripts/add.bm.sh")
files+=(".config/surf/scripts/dmenu.linkselect.sh")
files+=(".config/surf/scripts/dmenu.mpv.sh")
files+=(".config/surf/scripts/dmenu.setprop.sh")
files+=(".config/surf/scripts/dmenu.uri.sh")
files+=(".config/surf/scripts/edit.bookmarks.sh")
files+=(".config/surf/scripts/edit.screen.sh")
files+=(".config/surf/scripts/edit.url.sh")
files+=(".config/surf/scripts/link_hints.js")
files+=(".config/surf/scripts/open.help.sh")
files+=(".config/surf/styles/archlinux.css")
files+=(".config/surf/styles/github.css")
files+=(".config/surf/styles/homepage.css")
files+=(".config/surf/styles/suckless.css")
files+=(".config/surf/styles/wikipedia.css")
files+=(".config/surf/styles/youtube.css")
files+=(".config/sxhkd/sxhkdrc")
files+=(".config/tigrc")
files+=(".config/vifm/colors/molokai.vifm")
files+=(".config/vifm/vifmrc")
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
		echo "$HDIR/$SDIR exists, prepairing backup"
		echo "mkdir -p $DIR/old/$SDIR"
	else
		echo "$HDIR/$SDIR does not exist"
		echo "mkdir -p $HDIR/$SDIR"
	fi
  for script in ${scripts[@]}; do
    if [[ -f "$HDIR/$SDIR/$script" ]]; then
      echo "$HDIR/$SDIR/$script already exists"
      if [[ -f "$DIR/old/$SDIR/$script" ]]; then
        echo "backup already exists..."
      else
	     	echo "mv $HDIR/$SDIR/$script $DIR/old/$SDIR/$script"
      fi
      echo "cp -rf $DIR/$SDIR/$script $HDIR/$SDIR/$script"
    else
      echo "cp -rf $DIR/$SDIR/$script $HDIR/$SDIR/$script"
    fi
  done
}
install_files() {
	echo -e "\n[*] Installing files..."
  for file in ${files[@]}; do
    if [[ -f "$HDIR/$file" ]]; then
      echo "$HDIR/$file already exists"
      if [[ $(dirname $file) != "." ]]; then
        echo "mkdir -p $DIR/old/$(dirname $file)"
      fi
      if [[ -f "$DIR/old/$file" ]]; then
        echo "backup already exists..."
      else
	     	echo "mv $HDIR/$file $DIR/old/$file"
      fi
    fi
		echo "cp -rf $DIR/$file $HDIR/$file"
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
  read -p "[?] Install $1? (y/n) "
	if [[ $REPLY == "y" ]]; then
    $2
	elif [[ $REPLY == "n" ]]; then
		echo "Discarding $1 installation!"
	else
		echo -e "\n[!] Invalid Option, Aborting...\n"
		exit 1
	fi
}

main() {
	clear

	cat <<- EOF
		[*] Installing config...
    source: $DIR
    destination: $HDIR

	EOF
	# 	[*] Choose option-
	# 	[1/o] Override everything.
	# 	[2/m] Minimal install.
	# 	[3/i] Interactive installation.
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

  prompt_for_install_and_install "scripts" "install_scripts"
  prompt_for_install_and_install "files"   "install_files"
  prompt_for_install_and_install "fonts"   "install_fonts"
  prompt_for_install_and_install "repos"   "install_repos"

  echo "Bye bye!!"
}

main
