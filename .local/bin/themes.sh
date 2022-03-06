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

[[ ! -v DATABASE ]] && DATABASE="kovidgoyal/kitty-themes"
[[ ! -v BRANCH ]] && BRANCH="master"
[[ ! -v CACHE ]] && CACHE="$HOME/.cache/all-themes"
[[ ! -v COLORDATABASE ]] && COLORDATABASE="$CACHE/themes.csv"

[[ ! -v CONFIGS ]] && CONFIGS="qtile,dunst,alacritty,kitty"
[[ ! -v QTILE ]] && QTILE="$HOME/.config/qtile"
[[ ! -v DUNSTRC ]] && DUNSTRC="$HOME/.config/dunst/dunstrc"
[[ ! -v ALACRITTYYML ]] && ALACRITTYYML="$HOME/.config/alacritty/alacritty.yml"
[[ ! -v KITTYCONF ]] && KITTYCONF="$HOME/.config/kitty"
_nb_colors=20
_columns=(name bg fg sel_bg sel_fg 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)

update () {
  #
  # download the themes list from remote.
  # or sync the local repo with the remote.
  # 
  if [[ ! -d "$CACHE" ]]; then
    echo -e "Downloading themes from ${Src}$DATABASE${Off} to ${Dst}$CACHE${Off}.";
    git clone "https://github.com/$DATABASE.git" "$CACHE";
  else
    echo -e "Syncing ${Dst}$CACHE${Off} with ${Src}$DATABASE${Off}.";
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
    [ -f "$COLORDATABASE" ] && rm "$COLORDATABASE"
    echo "${_columns[@]}" | tr ' ' ',' | tee "$COLORDATABASE" -a > /dev/null
    for theme in $(ls "$CACHE/themes" | sed 's/\.conf$//g');
    do
      echo -en "Stripping ${Src}$theme${Off}... "
      colors=$(grep -Ev 'cursor|active|^\$|^#|url|mark' "$CACHE/themes/$theme.conf" |\
        sed 's/background/bg/; s/foreground/fg/; s/selection/sel/; /^\s*$/d;' |\
        sed 's/^color//g; s/\s\+/ /g;' |\
        sort -g | head -n 20)
      nb_lines=$(echo "$colors" | wc -l)
      if [ "$nb_lines" = "$_nb_colors" ];
      then
        # append the line to the theme database.
        echo -e "${Ok}ok${Off}"
        colors="$(echo "$colors" | awk '{print $2}' | tr '\n' ' ')"
        echo "$theme,$colors" | tr ' ' ',' | sed 's/,\s*$//g' | tee "$COLORDATABASE" -a > /dev/null
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
  if [[ -f "$COLORDATABASE" ]]; then
    if command -v bat &> /dev/null; then
      bat "$COLORDATABASE"
    else
      less "$COLORDATABASE"
    fi
  else
    echo -e "No database at ${Pmt}$COLORDATABASE${Off}."
    echo -e "Consider using ${Tip}themes.sh -s${Off} to generate the ${Dst}$COLORDATABASE${Off} database.";
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
  fields=(bg fg sel_bg sel_fg color0 color1 color2 color3 color4 color5 color6 color7 color8 color9 color10 color11 color12 color13 color14 color15)
  for i in $(seq 0 19);
  do
    sed -i "s/\(\s*\"${fields[$i]}\": \"\)#......\",\s*\$/\1$(echo "$1" | awk -F, "{print \$$(($i+1))}")\",/" "$QTILE/theme.py"
  done
  # change the name of the current theme
  sed -i "s/# current: .*/# current: $2/" "$QTILE/theme.py"
  # restart qtile
  if pgrep qtile > /dev/null;
  then
    qtile cmd-obj -o cmd -f restart
  fi
}

dunst_cfg () {
  #
  # change the theme of the dunst notification server.
  #
  # update the theme inside the dunstrc config file
  bg=$(echo "$1" | awk -F, "{print \$1}")
  cfg=$(echo "$1" | awk -F, "{print \$6}")
  cfc=$(echo "$1" | awk -F, "{print \$16}")
  nfg=$(echo "$1" | awk -F, "{print \$9}")
  lfg=$(echo "$1" | awk -F, "{print \$12}")
  sed -i "s/\(\s\+background\s\+=\s\+\"\)#......\(\"  # URGENCY_CRITICAL BG\)/\1$bg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+background\s\+=\s\+\"\)#......\(\"  # URGENCY_NORMAL BG\)/\1$bg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+background\s\+=\s\+\"\)#......\(\"  # URGENCY_LOW BG\)/\1$bg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+foreground\s\+=\s\+\"\)#......\(\"  # URGENCY_CRITICAL FG\)/\1$cfg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+foreground\s\+=\s\+\"\)#......\(\"  # URGENCY_NORMAL FG\)/\1$nfg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+foreground\s\+=\s\+\"\)#......\(\"  # URGENCY_LOW FG\)/\1$lfg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+frame_color\s\+=\s\+\"\)#......\(\"  # URGENCY_CRITICAL FC\)/\1$cfc\2/" "$DUNSTRC"
  # change the name of the theme.
  sed -i "s/# THEME: .*/# THEME: $2/" "$DUNSTRC"
  # restart dunst and show a preview
  killall dunst
  dunst -conf "$DUNSTRC" &
  dunstify "$(echo $theme | sed 's/.conf$//')" "this is a critical test" -u critical -t 10000
  dunstify "$(echo $theme | sed 's/.conf$//')" "this is a normal test" -u normal -t 10000
  dunstify "$(echo $theme | sed 's/.conf$//')" "this is a low test" -u low -t 10000
  dunstify "$(echo $theme | sed 's/.conf$//') (sample progress bar)" -h "int:value:40" -u low --icon=/usr/share/icons/Adwaita/16x16/legacy/audio-volume-medium.png -t 10000
}

alacritty_cfg () {
  #
  # change the theme of the alacritty terminal emulator.
  #
  sed -i "s/\(\s*background\s*:\s*'0x\)......\('\s*# PRIMARY\)/\1$(echo "$1" | awk -F, '{print $1}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*foreground\s*:\s*'0x\)......\('\s*# PRIMARY\)/\1$(echo "$1" | awk -F, '{print $2}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*text\s*:\s*'0x\)......\('\s*# CURSOR\)/\1$(echo "$1" | awk -F, '{print $3}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*cursor\s*:\s*'0x\)......\('\s*# CURSOR\)/\1$(echo "$1" | awk -F, '{print $4}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*black\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $5}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*red\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $6}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*green\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $7}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*yellow\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $8}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*blue\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $9}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*magenta\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $10}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*cyan\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $11}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*white\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $12}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*black\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $13}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*red\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $14}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*green\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $15}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*yellow\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $16}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*blue\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $17}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*magenta\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $18}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*cyan\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $19}' | sed 's/#//')\2/" "$ALACRITTYYML"
  sed -i "s/\(\s*white\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $20}' | sed 's/#//')\2/" "$ALACRITTYYML"
  # change the name of the theme.
  sed -i "s/\(\s*# COLORSCHEME: \).*/\1$2/" "$ALACRITTYYML"
}

kitty_cfg () {
  #
  # change the theme of the kitty terminal emulator.
  #
  if ! kitty +kitten themes --reload-in=all "$2" &> /dev/null;
  then
    echo "ok" | dmenu -bw 5 -p "'$2' is not a kitty theme..."
  fi
}

theme () {
  #
  # let the user pick a theme.
  # $1 is a preselected theme with the -t=THEME switch.
  #
  theme="$1"
  [ ! "$theme" ] && theme=" "
  if [[ -f "$COLORDATABASE" ]]; then
    if ! awk -F, '{print $1}' "$COLORDATABASE" | grep -we "$theme" -q;
    then
      echo -e "${Err}'$theme' not in $COLORDATABASE${Off}"
      theme=$(tail -n +2 "$COLORDATABASE" | awk -F, '{print $1}' | dmenu -bw 5 -c -l 20 -i -p "Choose a theme: ")
      [ ! "$theme" ] && { echo -e "${Wrn}No theme selected${Off}"; exit 0; }
      echo -e "${Ok}'$theme' selected${Off}"
    else 
      echo -e "${Tip}'$theme' found in $COLORDATABASE${Off}"
    fi
    colors=$(grep -w "$theme" "$COLORDATABASE" | sed "s/$theme,//")
    for config in $(echo "$2" | tr ',' ' ');do
      case "$config" in
        qtile ) qtile_cfg "$colors" "$theme";;
        dunst ) dunst_cfg "$colors" "$theme";;
        alacritty ) alacritty_cfg "$colors" "$theme";;
        kitty ) kitty_cfg "$colors" "$theme";;
        * ) echo "an error occured (got unexpected config '$config')"; exit 1 ;;
      esac
    done
  else
    echo -e "No database at ${Pmt}$COLORDATABASE${Off}."
    echo -e "Consider using ${Tip}themes.sh -s${Off} to generate the ${Dst}$COLORDATABASE${Off} database.";
  fi
}

usage () {
  #
  # the usage function.
  #
  echo "Usage: themes.sh [-huscpa] [-t=THEME] [-C=C1,C2]"
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
  echo "     themes.sh [-huscpa] [-t=THEME] [-C=C1,C2]"
  echo ""
  echo "Switches:"
  echo "     -h/--help           shows this help."
  echo "     -u/--update         download the database or sync the repo."
  echo "     -s/--strip          strip the theme files to keep only relevant colors."
  echo "     -c/--clean          clean the cache."
  echo "     -p/--print          print the local database."
  echo "     -t/--theme[=THEME]  pick a theme from the local database, possibly with default one."
  echo "     -C/--config=C1,C2   give the configs to apply the selected theme on."
  echo "     -a/--all            same as -C=all."
  echo ""
  echo "Environment variables:"
  echo "     DATABASE            the remote database (defaults to 'kovidgoyal/kitty-themes)"
  echo "     BRANCH              the branch to use on the remote (defaults to 'master')"
  echo "     CACHE               the location of the cache (defaults to '\$HOME/.cache/all-themes')"
  echo "     COLORDATABASE       the final local database (defaults to '\$CACHE/themes.csv')"
  echo "     CONFIGS             the list of all implemented configs (defaults to 'qtile,dunst,alacritty')"
  echo "     QTILE               the path to the qtile config (defaults to '\$HOME/.config/qtile')"
  echo "     DUNSTRC             the path to the dunst config file (defaults to '\$HOME/.config/dunst/dunstrc')"
  echo "     ALACRITTYYML        the path to the alacritty config file (defaults to '\$HOME/.config/alacritty/alacritty.yml')"
  echo "     KITTYCONF           the path to the kitty config (defaults to '\$HOME/.config/kitty')"
  exit 0
}

# parse the arguments.
OPTIONS=$(getopt -o huscpt::C:a --long help,update,strip,clean,print,theme::,config:,all -n 'themes.sh' -- "$@")
if [ $? != 0 ] ; then usage >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -u | --update ) ACTION="update"; shift 1 ;;
      -s | --strip ) ACTION="strip"; shift 1 ;;
      -c | --clean ) ACTION="clean"; shift 1 ;;
      -p | --print ) ACTION="print"; shift 1 ;;
      -t | --theme ) ACTION="theme"; theme="$(echo "$2" | sed 's/^=//')" ; shift 2;;
      -C | --config ) ACTION="theme"; CONFIG="$(echo "$2" | sed 's/^=//')"; shift 2 ;;
      -a | --all ) CONFIG="all"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
  [ "$CONFIG" = "all" ] && CONFIG="$CONFIGS"

  # an action is required
  [ -z "$ACTION" ] && usage
  case "$ACTION" in
    update ) update ;;
    strip )  strip ;;
    clean )  clean ;;
    print )  print ;;
    theme )  theme "$theme" "$CONFIG" ;;
    * ) echo "an error occured (got unexpected action '$ACTION')"; exit 1 ;;
  esac
}

main "$@"
