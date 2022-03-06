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

theme () {
  #
  # let the user pick a theme.
  # $1 is a preselected theme with the -t=THEME switch.
  #
  if [[ -f "$COLORDATABASE" ]]; then
    if ! awk -F, '{print $1}' "$COLORDATABASE" | grep -we "$1" -q;
    then
      echo -e "${Err}'$1' not in $COLORDATABASE${Off}"
      theme=$(tail -n +2 "$COLORDATABASE" | awk -F, '{print $1}' | dmenu -l 20 -i -p "Choose a theme: ")
      [ ! "$theme" ] && { echo -e "${Wrn}No theme selected${Off}"; exit 0; }
      echo -e "${Ok}'$theme' selected${Off}"
    else 
      theme="$1"
      echo -e "${Tip}'$1' found in $COLORDATABASE${Off}"
    fi
  else
    echo -e "No database at ${Pmt}$COLORDATABASE${Off}."
    echo -e "Consider using ${Tip}themes.sh -s${Off} to generate the ${Dst}$COLORDATABASE${Off} database.";
  fi
}

# parse the arguments.
OPTIONS=$(getopt -o huscpt:: --long help,update,strip,clean,print,theme:: -n 'themes.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

usage () {
  #
  # the usage function.
  #
  echo "Usage: themes.sh [-huscp] [-t=THEME]"
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
  echo "     themes.sh [-huscp] [-t=THEME]"
  echo ""
  echo "Switches:"
  echo "     -h/--help           shows this help."
  echo "     -u/--update         download the database or sync the repo."
  echo "     -s/--strip          strip the theme files to keep only relevant colors."
  echo "     -c/--clean          clean the cache."
  echo "     -p/--print          print the local database."
  echo "     -t/--theme[=THEME]  pick a theme from the local database, possibly with default one."
  echo ""
  echo "Environment variables:"
  echo "     DATABASE            the remote database (defaults to 'kovidgoyal/kitty-themes)"
  echo "     BRANCH              the branch to use on the remote (defaults to 'master')"
  echo "     CACHE               the location of the cache (defaults to '\$HOME/.cache/all-themes')"
  echo "     COLORDATABASE       the final local database (defaults to '\$CACHE/themes.csv')"
  exit 0
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -u | --update ) ACTION="update"; shift 1 ;;
      -s | --strip ) ACTION="strip"; shift 1 ;;
      -c | --clean ) ACTION="clean"; shift 1 ;;
      -p | --print ) ACTION="print"; shift 1 ;;
      -t | --theme ) ACTION="theme"; theme="$(echo "$2" | sed 's/^=//')" ; shift 2;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  # an action is required
  [ -z "$ACTION" ] && usage
  case "$ACTION" in
    update ) update ;;
    strip )  strip ;;
    clean )  clean ;;
    print )  print ;;
    theme )  theme "$theme" ;;
    * ) echo "an error occured (got unexpected '$ACTION')"; exit 1 ;;
  esac
}

main "$@"
