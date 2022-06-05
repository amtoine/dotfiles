#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#        _     __  _        __  _   _                          _
#       | |   / / | |__    / / | |_| |_  ___ _ __  ___ ___  __| |_
#      _| |  / /  | '_ \  / /  |  _| ' \/ -_) '  \/ -_|_-<_(_-< ' \
#     (_)_| /_/   |_.__/ /_/    \__|_||_\___|_|_|_\___/__(_)__/_||_|
#
# Description:  manages all the themes of my desktop environment.
# Dependencies:
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
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
# High Intensity
IRed=$(printf '\033[0;91m')    # Red
IGrn=$(printf '\033[0;92m')    # Green
IYlw=$(printf '\033[0;93m')    # Yellow
IBlu=$(printf '\033[0;94m')    # Blue
IPur=$(printf '\033[0;95m')    # Purple
IWht=$(printf '\033[0;97m')    # White
################################################################################################
## 'Global constants' definitions ##############################################################
################################################################################################
# Specific color use. #
#######################
Ok=$Grn    # ok statement
Err=$IRed  # errors
Wrn=$IYlw  # warnings
Cod=$IBlu  # code
Hed=$IPur  # head
Src=$Pur   # source
Dst=$Grn   # destination
Pmt=$Cyn   # prompt
Tip=$IGrn  # tip

[[ ! -v REMOTE ]] && REMOTE="kovidgoyal/kitty-themes"
[[ ! -v BRANCH ]] && BRANCH="master"
CACHE="$HOME/.cache/all-themes"
colordatabase="$CACHE/themes.csv"
colorpreview="$CACHE/themes.clr"
[[ ! -v QTILE ]] && QTILE="$HOME/.config/qtile"
[[ ! -v DUNST ]] && DUNST="$HOME/.config/dunst/dunstrc"
[[ ! -v ALACRITTY ]] && ALACRITTY="$HOME/.config/alacritty/alacritty.yml"
[[ ! -v KITTY ]] && KITTY="$HOME/.config/kitty/kitty.conf"
[[ ! -v CONKY ]] && CONKY="$HOME/.config/conky"
[[ ! -v SUCKLESS ]] && SUCKLESS="$HOME/ghq/git.suckless.org"
[[ ! -v XRESOURCES ]] && XRESOURCES="$HOME/.Xresources"
[[ ! -v ROFI ]] && ROFI="$HOME/.config/rofi/all.rasi"
GRUB="/usr/share/grub/themes"
SDDM="/usr/share/sddm/themes"
_columns=(name bg fg sel_bg sel_fg 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
_nb_colors="$(( ${#_columns[@]}-1 ))"

update () {
  #
  # download the themes list from remote.
  # or sync the local repo with the remote.
  # 
  if [[ ! -d "$CACHE" ]]; then
    echo -e "Downloading themes from ${Src}$REMOTE${Off} to ${Dst}$CACHE${Off}.";
    git clone "https://github.com/$REMOTE.git" "$CACHE";
  else
    echo -e "Syncing ${Dst}$CACHE${Off} with ${Src}$REMOTE${Off}.";
    git -C "$CACHE" checkout "$BRANCH" || exit 1;
    git -C "$CACHE" pull origin || exit 1;
  fi
}

strip () {
  #
  # strips the themes in the cache to
  # keep only relevant colors
  #
  if [[ -d "$CACHE" ]]; then
    [ -f "$colordatabase" ] && rm "$colordatabase"
    [ -f "$colorpreview" ] && rm "$colorpreview"
    echo "${_columns[@]}" | tr ' ' ',' | tee "$colordatabase" -a > /dev/null
    themes=($(ls "$CACHE/themes" | sed 's/\.conf$//g'))
    for (( i = 0; i < "${#themes[@]}"; i++ ));
    do
      theme="${themes[$i]}"
      echo -en "[$((i+1)) / ${#themes[@]}] ${Src}$theme${Off}... "
      colors=$(grep -Ev 'cursor|active|^\$|^#|url|mark|color ' "$CACHE/themes/$theme.conf" |\
        sed 's/background/bg/; s/foreground/fg/; s/selection/sel/; /^\s*$/d;' |\
        sed 's/^color//g; s/\s\+/ /g;' |\
        sort -g | head -n 20)
      nb_lines=$(echo "$colors" | wc -l)
      if [ "$nb_lines" = "$_nb_colors" ];
      then
        # append the line to the theme database.
        colors="$(echo "$colors" | awk '{print $2}' | tr '\n' ',' | sed 's/,\s*$//g')"
        echo "$theme,$colors" | tee "$colordatabase" -a > /dev/null
        # add the theme preview to $colorpreview
        _gencols.fish "$(echo "$theme,$colors")" | tee "$colorpreview" -a > /dev/null
        echo -e "${Ok}ok${Off}"
      else
        # explain a bit the error to the user.
        echo -e "${Err}not ok${Off} (${Wrn}expected $_nb_colors colors but got $nb_lines${Off})"
        if ! echo "$colors" | grep -e "bg" -q;
        then
          echo -e "${Wrn}  missing bg${Off}"
        fi
        if ! echo "$colors" | grep -e "fg" -q;
        then
          echo -e "${Wrn}  missing fg${Off}"
        fi
        if ! echo "$colors" | grep -e "sel_bg" -q;
        then
          echo -e "${Wrn}  missing sel_bg${Off}"
        fi
        if ! echo "$colors" | grep -e "sel_fg" -q;
        then
          echo -e "${Wrn}  missing sel_fg${Off}"
        fi
      fi
    done
    echo "${Dst}Done${Off}"
  else
    echo -e "No cache to clean at ${Pmt}$CACHE${Off}."
    echo -e "Consider using ${Tip}themes.sh -u${Off} to update the cache.";
  fi
}

print () {
  #
  # print the whole database.
  #
  if [[ -f "$colordatabase" ]]; then
    if command -v bat &> /dev/null; then
      column -t -s ',' "$colordatabase" | bat --wrap=never
    else
      column -t -s ',' "$colordatabase" | less
    fi
  else
    echo -e "No database at ${Pmt}$colordatabase${Off}."
    echo -e "Consider using ${Tip}themes.sh -s${Off} to generate the ${Dst}$colordatabase${Off} database.";
  fi
}

preview () {
  #
  # preview the whole database.
  #
  if [[ -f "$colorpreview" ]]; then
    if command -v bat &> /dev/null; then
      bat "$colorpreview" --wrap=never
    else
      less "$colorpreview"
    fi
  else
    echo -e "No database at ${Pmt}$colorpreview${Off}."
    echo -e "Consider using ${Tip}themes.sh -s${Off} to generate the ${Dst}$colorpreview${Off} database.";
  fi
}

clean () {
  #
  # clean the whole cache.
  #
  if [[ -d "$CACHE" ]]; then
    echo -e "Cleaning cache at ${Src}$CACHE${Off}.";
    rm -rf "$CACHE";
  else
    echo -e "No cache to clean at ${Pmt}$CACHE${Off}."
    echo -e "Consider using ${Tip}themes.sh -u${Off} to update the cache.";
  fi
}

qtile_cfg () {
  #
  # Change the theme of qtile.
  #

  # change all the fields
  echo -e "Changing ${Dst}qtile${Off}'s theme to ${Src}'$2'${Off}"
  colors="$1"

  a=(bg fg sel_bg sel_fg color0 color1 color2 color3 color4 color5 color6 color7 color8 color9 color10 color11 color12 color13 color14 color15)
  for ((i = 0; i < "${#a[@]}"; i++));
  do
    sed -i "s/\(\s*\"${a[$i]}\": \"\)#......\",\s*\$/\1${colors[$i]}\",/" "$QTILE/theme.py"
  done
  # change the name of the current theme
  sed -i "s/# current: .*/# current: $2/" "$QTILE/theme.py"
  # restart qtile
  if pgrep qtile > /dev/null;
  then
    qtile cmd-obj -o cmd -f restart
  fi
  # changes the conky as well
  sed -i "s/\(\s\+color0\s\+=\s\+\)'#......',/\1'${colors[8]}',/" "$CONKY/qtile.conkyrc"
  sed -i "s/\(\s\+color1\s\+=\s\+\)'#......',/\1'${colors[11]}',/" "$CONKY/qtile.conkyrc"
  sed -i "s/\(\s\+color2\s\+=\s\+\)'#......',/\1'${colors[10]}',/" "$CONKY/qtile.conkyrc"
  sed -i "s/\(\s\+color3\s\+=\s\+\)'#......',/\1'${colors[6]}',/" "$CONKY/qtile.conkyrc"
  sed -i "s/\(\s\+--Colors \).*/\1$2/" "$CONKY/qtile.conkyrc"
}

dunst_cfg () {
  #
  # change the theme of the dunst notification server.
  #
  # update the theme inside the dunstrc config file
  echo -e "Changing ${Dst}dunst${Off}'s theme to ${Src}'$2'${Off}"
  colors="$1"

  a=("background" "background" "background" "foreground" "foreground" "foreground" "frame_color")
  b=("CRITICAL"   "NORMAL"     "LOW"        "CRITICAL"   "NORMAL"     "LOW"        "CRITICAL")
  c=(0            0            0            5            8            11           15)
  for ((i = 0; i < "${#a[@]}"; i++));
  do
    sed -i "s/\(\s\+${a[$i]}\s\+=\s\+\"\)#......\(\"  # ${b[$i]}\)/\1${colors[${c[$i]}]}\2/" "$DUNST"
  done
  # change the name of the theme.
  sed -i "s/# THEME: .*/# THEME: $2/" "$DUNST"
  # restart dunst and show a preview
  killall dunst
  dunst -conf "$DUNST" &
  dunstify "${theme//\.conf$//}" "this is a critical test" -u critical -t 10000
  dunstify "${theme//\.conf$//}" "this is a normal test" -u normal -t 10000
  dunstify "${theme//\.conf$//}" "this is a low test" -u low -t 10000
  dunstify "${theme//\.conf$//} (sample progress bar)" -h "int:value:40" -u low --icon="$HOME/.icons/volume.png" -t 10000
}

alacritty_cfg () {
  #
  # change the theme of the alacritty terminal emulator.
  #
  echo -e "Changing ${Dst}alacritty${Off}'s theme to ${Src}'$2'${Off}"
  colors="$1"

  a=(background foreground text   cursor black  red    green  yellow blue   magenta cyan   white  black  red    green  yellow blue   magenta cyan   white)
  b=(PRIMARY    PRIMARY    CURSOR CURSOR NORMAL NORMAL NORMAL NORMAL NORMAL NORMAL  NORMAL NORMAL BRIGHT BRIGHT BRIGHT BRIGHT BRIGHT BRIGHT  BRIGHT BRIGHT)
  for ((i = 0; i < "${#a[@]}"; i++));
  do
    sed -i "s/\(\s*${a[$i]}\s*:\s*'0x\)......\('\s*# ${b[$i]}\)/\1${colors[$i]//#/}\2/" "$ALACRITTY"
  done
  # change the name of the theme.
  sed -i "s/\(\s*# COLORSCHEME: \).*/\1$2/" "$ALACRITTY"
}

kitty_cfg () {
  #
  # change the theme of the kitty terminal emulator.
  #
  echo -e "Changing ${Dst}kitty${Off}'s theme to ${Src}'$2'${Off}"
  colors="$1"

  a=(background foreground selection_background selection_foreground color0 color1 color2 color3 color4 color5 color6 color7 color8 color9 color10 color11 color12 color13 color14 color15)
  for ((i = 0; i < "${#a[@]}"; i++));
  do
    sed -i "s/\(^${a[$i]}\s*\)#....../\1${colors[$i]}/" "$KITTY"
  done
  # change the name of the theme.
  sed -i "s/\(^# THEME: \).*/\1$2/" "$KITTY"
}

rofi_cfg () {
  #
  # change the theme of rofi.
  #
  echo -e "Changing ${Dst}rofi${Off}'s theme to ${Src}'$2'${Off}"
  colors="$1"

  a=(bg fg selbg selfg color0 color1 color2 color3 color4 color5 color6 color7 color8 color9 color10 color11 color12 color13 color14 color15)
  for ((i = 0; i < "${#a[@]}"; i++));
  do
    sed -i "s/\(\s*${a[$i]}:\s\+\)#......;/\1${colors[$i]};/" "$ROFI"
  done
  # change the name of the theme.
  sed -i "s/\(^\/\/ THEME: \).*/\1$2/" "$ROFI"
}
dmenu_cfg () {
  #
  # change the theme of dmenu.
  #
  echo -e "Changing ${Dst}dmenu${Off}'s theme to ${Src}'$2'${Off}"
  colors="$1"

  [ ! -f "$SUCKLESS/dmenu/config.h" ] && cp "$SUCKLESS/dmenu/config.def.h" "$SUCKLESS/dmenu/config.h"
  a=(SchemeSel SchemeSelOut SchemeMid SchemeMidOut SchemeSelHighlight SchemeNormHighlight SchemeNorm SchemeOut)
  b=(4         4            1         1            6                  6                   1          4)
  c=(9         10           2         12           4                  4                   0          1)
  for ((i = 0; i < "${#a[@]}"; i++));
  do
    sed -i "s/\(\[${a[$i]}\]\s\+= { \"\)#......\", \"#......\(\" },\)/\1${colors[${b[$i]}]}\", \"${colors[${c[$i]}]}\2/" "$SUCKLESS/dmenu/config.h"
  done
  # change the name of the theme.
  sed -i "s/\(^\/\/ THEME: \).*/\1$2/" "$SUCKLESS/dmenu/config.h"
  cd "$SUCKLESS/dmenu" > /dev/null || exit 1
  sudo make clean install
  cd - > /dev/null || exit 1
}

st_cfg () {
  #
  # change the theme of st.
  #
  echo -e "Changing ${Dst}st${Off}'s theme to ${Src}'$2'${Off}"
  colors="$1"

  [ ! -f "$SUCKLESS/st/config.h" ] && cp "$SUCKLESS/st/config.def.h" "$SUCKLESS/st/config.h"
  a=(4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 0 1)
  for ((i = 0; i < "${#a[@]}"; i++));
  do
    sed -i "s/\[$i\] = \"#......\",/[$i] = \"${colors[${a[$i]}]}\",/" "$SUCKLESS/st/config.h"
  done
  # change the name of the theme.
  sed -i "s/\(^\/\/ THEME: \).*/\1$2/" "$SUCKLESS/st/config.h"
  cd "$SUCKLESS/st" > /dev/null || exit 1
  sudo make clean install
  cd - > /dev/null || exit 1
  [ "$(echo -e "No\nYes" | dmenu -c -l 2 -bw 5 -i -p "Kill all instances of st to apply changes: ")" = "Yes" ] && killall st
}

xresources_cfg () {
  #
  # change the theme of doom emacs and neovim.
  #
  echo -e "Changing ${Dst}xresources${Off}' theme to ${Src}'$2'${Off}"
  colors="$1"

  a=(background foreground pointerColorBackground pointerColorForeground cursorColor fadeColor color0 color1 color2 color3 color4 color5 color6 color7 color9 color8 color10 color11 color12 color13 color14 color15)
  b=(0          1          2                      3                      3           4         4      5      6      7      8      9      10     11     12     13     14      15      16      17      18      19)
  for ((i = 0; i < "${#a[@]}"; i++));
  do
    sed -i "s/^\(\*${a[$i]}:\s\+\)#....../\1${colors[${b[$i]}]}/" "$XRESOURCES"
  done
  # change the name of the theme.
  sed -i "s/\(^! THEME: \).*/\1$2/" "$XRESOURCES"
  xrdb -load "$XDG_CONFIG_HOME/X11/xresources"

  [ "$(echo -e "No\nYes" | dmenu -c -l 2 -bw 5 -i -p "Kill all instances of emacs to apply changes: ")" = "Yes" ] && killall emacs
}

grub_cfg () {
  #
  # change the theme of grub
  #
  echo -e "Changing ${Dst}grub${Off}' theme${Off}"
  choices=($(ls "$GRUB" | dmenu -c -l 8 -bw 5 -p "Pick a theme from $GRUB: "))
  [ ! "$choices" ] && { echo -e "${Wrn}No theme selected for grub${Off}"; return; }
  choice="${choices[0]}"
  [ ! -f "$GRUB/$choice/theme.txt" ] && { echo -e "${Wrn}No theme.txt found in $GRUB/$choice${Off}"; return; }
  sudo sed -i "s|^GRUB_THEME=\"$GRUB/.*/theme.txt\"|GRUB_THEME=\"$GRUB/$choice/theme.txt\"|" /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg

  [ "$(echo -e "No\nYes" | dmenu -c -l 2 -bw 5 -i -p "Reboot: ")" = "Yes" ] && reboot
}

sddm_cfg () {
  #
  # change the theme of sddm
  #
  echo -e "Changing ${Dst}sddm${Off}' theme${Off}"
  choice=($(ls "$SDDM" | dmenu -c -l 8 -bw 5 -p "Pick a theme from $SDDM: "))
  [ ! "$choice" ] && { echo -e "${Wrn}No theme selected for sddm${Off}"; exit 0; }
  sudo sed -i "s/^Current=.*/Current=${choice[0]}/" /etc/sddm.conf
  [ "$(echo -e "No\nYes" | dmenu -c -l 2 -bw 5 -i -p "Restart sddm: ")" = "Yes" ] && sudo systemctl restart sddm.service
}

dmenu_support () {
  #
  # allow the user to choose options
  # with dmenu
  #

  # choose the actions to perform
  choices=($(echo -e "clean\nupdate\nstrip\ntheme" | dmenu -c -bw 5 -l 20 -p "Choose an option: " | sort -u))
  [ ! "$choices" ] && { echo -e "${Wrn}User choose to exit${Off}"; return; }
  ACTIONS=()
  for choice in "${choices[@]}"; do
    case "$choice" in
      clean )   ACTIONS+=("0") ;;
      update )  ACTIONS+=("1" "2") ;;
      strip )   ACTIONS+=("2") ;;
      theme )   ACTIONS+=("5"); totheme="_" ;;
    esac
  done
  [ -z "$totheme" ] && return

  # choose the configs to modify
  choices=($(echo -e "all\nother\nboot" | dmenu -c -bw 5 -l 20 -p "Configs to change: " | sort -u))
  [ ! "$choices" ] && { echo -e "${Wrn}User choose to exit${Off}"; return; }
  CONFIGS=("$choices")
}

theme () {
  #
  # let the user pick a theme.
  # $1 is a preselected theme with the -t=THEME switch.
  #
  theme=$(echo "$1" | sed 's/^\s*//g; s/\s*$//g')
  [ ! "$theme" ] && theme="DEFAULT_TO_DMENU"
  if [[ -f "$colordatabase" ]]; then
    if grep -E "qtile|dunst|alacritty|kitty|xesources|rofi|dmenu|st" -q <<< "${CONFIGS[@]}";
    then
      # extract the theme colors, either directly if -t is valid
      # or with dmenu
      if ! awk -F, '{print $1}' "$colordatabase" | grep -we "${theme// /_}" -q;
      then
        echo -e "${Err}'$theme' not in $colordatabase${Off}"
        theme=$(tail -n +2 "$colordatabase" | awk -F, '{print $1}' | sed 's/_/ /g' | dmenu -bw 5 -c -l 20 -i -p "Choose a theme: ")
        [ ! "$theme" ] && { echo -e "${Wrn}No theme selected${Off}"; exit 0; }
        echo -e "${Ok}'$theme' selected${Off}"
      else
        echo -e "'$theme' ${Tip}found${Off} in $colordatabase"
      fi
      theme="${theme// /_}"
      # put the colors in an array for easier color access later
      colors=($(grep -w "$theme" "$colordatabase" | sed "s/$theme,//; s/,/ /g"))
    fi

    # modify the configs accordingly
    for config in ${CONFIGS[@]};do
      case "$config" in
        qtile ) qtile_cfg "$colors" "$theme";;
        dunst ) dunst_cfg "$colors" "$theme";;
        alacritty ) alacritty_cfg "$colors" "$theme";;
        kitty ) kitty_cfg "$colors" "$theme";;
        xresources ) xresources_cfg "$colors" "$theme";;
        rofi ) rofi_cfg "$colors" "$theme";;
        dmenu ) dmenu_cfg "$colors" "$theme";;
        st ) st_cfg "$colors" "$theme";;
        grub ) grub_cfg ;;
        sddm ) sddm_cfg ;;
        * ) echo "an error occured (got unexpected config '$config')"; exit 1 ;;
      esac
    done
  else
    echo -e "No database at ${Pmt}$colordatabase${Off}."
    echo -e "Consider using ${Tip}themes.sh -s${Off} to generate the ${Dst}$colordatabase${Off} database.";
  fi
}

usage () {
  #
  # the usage function.
  #
  echo "Usage: themes.sh [-huscpaPd] [-t=THEME] [-C=C1,C2]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "themes.sh:"
  echo "     This script allows the user to easily download"
  echo "     preprocess and change colorschemes."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     themes.sh [-huscpPaob] [-t=THEME] [-C=C1,C2]"
  echo ""
  echo "Switches:"
  echo "     -h/--help           shows this help."
  echo "     -u/--update         download the database or sync the repo."
  echo "     -s/--strip          strip the theme files to keep only relevant colors."
  echo "     -c/--clean          clean the cache."
  echo "     -p/--print          print the local database."
  echo "     -P/--preview        preview the local database."
  echo "     -t/--theme[=THEME]  pick a theme from the local database, possibly with default one."
  echo "     -C/--config=C1,C2   give the configs to apply the selected theme on."
  echo "                         Can be a comma or space separated list."
  echo "                         One can use '-C=a,b,c', '-C \"a,b,c\"', '-C \"a b c\"', etc"
  echo "     -a/--all            same as -C=all"
  echo "     -b/--boot           applications that run at boot time and do not require 'real' themes."
  echo "                         same as -C=grub,sddm"
  echo "     -o/--other          all the other themeable applications."
  echo "                         same as -C=qtile,dunst,alacritty,kitty,xresources,dmenu,st"
  echo "     -d/--dmenu          allow to use the script from dmenu"
  echo ""
  echo "Environment variables:"
  echo "     REMOTE              the remote database (defaults to 'kovidgoyal/kitty-themes)"
  echo "     BRANCH              the branch to use on the remote (defaults to 'master')"
  echo "     CACHE**             the location of the cache (set to '\$HOME/.cache/all-themes')"
  echo "     QTILE               the path to the qtile config (defaults to '\$HOME/.config/qtile')"
  echo "     DUNST               the path to the dunst config file (defaults to '\$HOME/.config/dunst/dunstrc')"
  echo "     ALACRITTY           the path to the alacritty config file (defaults to '\$HOME/.config/alacritty/alacritty.yml')"
  echo "     KITTY               the path to the kitty config file (defaults to '\$HOME/.config/kitty/kitty.conf')"
  echo "     CONKY               the path to all the conky configs (defaults to '\$HOME/.config/conky')"
  echo "     SUCKLESS            the path to the suckless source codes (defaults to '\$HOME/ghq/git.suckless.org')"
  echo "     XRESOURCES          the location of the xresources, used for Doom Emacs and Neovim (defaults to '\$HOME/.Xresources)"
  echo "     GRUB**              the location of the grub themes (set to '/usr/share/grub/themes/')"
  echo "     SDDM**              the location of the sddm themes (set to '/usr/share/sddm/themes/')"
  echo "     ROFI                the path to the rofi theme file (defaults to '\$HOME/.config/rofi/all.rasi')"
  echo " ** cannot be changed"
  exit 0
}

# parse the arguments.
OPTIONS=$(getopt -o huscpt::C:aPbod --long help,update,strip,clean,print,theme::,config:,all,preview,boot,other,dmenu -n 'themes.sh' -- "$@")
if [ $? != 0 ] ; then usage >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

main () {
  ACTIONS=()
  CONFIGS=()
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -c | --clean )   ACTIONS+=("0"); shift 1 ;;
      -u | --update )  ACTIONS+=("1" "2"); shift 1 ;;
      -s | --strip )   ACTIONS+=("2"); shift 1 ;;
      -p | --print )   ACTIONS+=("3"); shift 1 ;;
      -P | --preview ) ACTIONS+=("4"); shift 1 ;;
      -C | --config )  ACTIONS+=("5"); CONFIGS+=($(echo "$2" | sed 's/^=//; s/,/ /g')); shift 2 ;;
      -a | --all )     ACTIONS+=("5"); CONFIGS=("all"); shift 1 ;;
      -o | --other )   ACTIONS+=("5"); CONFIGS=("other"); shift 1 ;;
      -b | --boot )    ACTIONS+=("5"); CONFIGS=("boot"); shift 1 ;;
      -t | --theme )   theme="$(echo "$2" | sed 's/^=//')" ; shift 2;;
      -d | --dmenu )   dmenu_support; break;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
  for config in "${CONFIGS[@]}"; do
    [ "$config" = "all" ] && { CONFIGS=("qtile" "dunst" "alacritty" "kitty" "xresources" "rofi" "dmenu" "grub" "sddm" "st"); break; }
    [ "$config" = "other" ] && { CONFIGS=("qtile" "dunst" "alacritty" "kitty" "xresources" "rofi" "dmenu" "st"); break; }
    [ "$config" = "boot" ] && { CONFIGS=("grub" "sddm"); break; }
  done

  # an action is required
  [ -z "$ACTIONS" ] && usage
  ACTIONS=($(echo "${ACTIONS[@]}" | tr ' ' '\n' | sort -u))
  for action in "${ACTIONS[@]}"; do
    case "$action" in
      0 ) clean ;;
      1 ) update ;;
      2 ) strip ;;
      3 ) print ;;
      4 ) preview ;;
      5 ) theme "$theme" ;;
      * ) echo "an error occured (got unexpected action '$action')"; exit 1 ;;
    esac
  done
}

main "$@"
