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
CDIR=".lolconfig"
SDIR="lolscripts"
RDIR="lolrepos"

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

		[*] Choose option-
		[1] ...
		[2] ...

	EOF

  prompt_for_install_and_install "scripts" "install_scripts"
  prompt_for_install_and_install "files"   "install_files"
  prompt_for_install_and_install "fonts"   "install_fonts"
  prompt_for_install_and_install "repos"   "install_repos"

  echo "Bye bye!!"
}

main
