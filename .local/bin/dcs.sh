#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#             __     _            _
#      ___   / /  __| |__ ___  __| |_
#     (_-<  / /  / _` / _(_-<_(_-< ' \
#     /__/ /_/   \__,_\__/__(_)__/_||_|
#
# Description:  change the theme of dunst with fzf
# Dependencies: fzf
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

################################################################################################
## Some color definitions ######################################################################
################################################################################################
# Reset
Off=$(printf '\033[0m')        # Text Reset
# Regular Colors
Grn=$(printf '\033[0;32m')     # Green
Pur=$(printf '\033[0;35m')     # Purple
# High Intensity
IRed=$(printf '\033[0;91m')    # Red
IYlw=$(printf '\033[0;93m')    # Yellow
################################################################################################
## 'Global constants' definitions ##############################################################
################################################################################################
# Specific color use. #
#######################
Err=$IRed  # errors
Wrn=$IYlw  # warnings
Src=$Pur   # source
Dst=$Grn   # destination

# the environment variables
[[ ! -v REPO ]] && REPO="kovidgoyal/kitty-themes"
[[ ! -v CACHE ]] && CACHE="$HOME/.cache/dunst/themes"
[[ ! -v DUNSTRC ]] && DUNSTRC="$HOME/.config/dunst/dunstrc"

export FZF_DEFAULT_OPTS="
--height=100%
--layout=reverse
--prompt='Change dunst colorscheme: '
--preview=\"cat $CACHE/themes/{1} | sed 's/#/%#/' | column -t -s '\%'\""

# parse the arguments.
OPTIONS=$(getopt -o h --long help -n 'dcs.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

help () {
  #
  # the help function.
  #
  echo "dcs.sh:"
  echo "     This script allows the user to easily change"
  echo "     dunst's theme."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     dcs.sh [-h] [THEME]"
  echo ""
  echo "Switches:"
  echo "     -h/--help   shows this help."
  echo ""
  echo "Environment variables:"
  echo "     REPO        the path to the remote where the themes are stored (defaults to 'kovidgoyal/kitty-themes')"
  echo "     CACHE       the path where the themes are stored locally       (defaults to '\$HOME/.cache/dunst/themes')"
  echo "     DUNSTRC     the path where dunst is configured                 (defaults to '\$HOME/.config/dunst/dunstrc')"
  exit 0
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  # download the themes list from remote.
  if [[ ! -d "$CACHE" ]]; then
    echo "Downloading themes from ${Src}$REPO${Off} to ${Dst}$CACHE${Off}.";
    git clone "https://github.com/$REPO.git" "$CACHE";
    for theme in $(ls "$CACHE/themes");
    do
      echo "Stripping ${Src}$theme${Off}"
      grep -Ev 'cursor|active|^\$|^#|url|mark' "$CACHE/themes/$theme" | sed 's/background/bg/; s/foreground/fg/; s/selection/sel/; s/^\s*//g; s/^\s\+/ /g' > "$CACHE/_tmp.conf"
      cat "$CACHE/_tmp.conf" > "$CACHE/themes/$theme"
    done
    echo "${Dst}Done${Off}"
  fi

  # check if the first argument is inside the database
  if [ ! -z "$1" ];
  then
    if ls "$CACHE/themes" | sed 's/\.conf$//g' | grep -w "$1"
    then
      theme="$1.conf"
    else
      echo "No theme named: $1"
      exit 1
    fi
  # otherwise use fzf to let the user choose the theme.
  else
    theme=$(find "$CACHE/themes" -type f | sed 's/.*\/\(.*.conf\)/\1/;' | sort | fzf)
    if [ "$theme" == "" ]; then
      echo "${Wrn}No theme selected. Aborting.${Off}";
      exit 1
    fi
  fi

  # update the theme inside the dunstrc config file
  bg=$(grep "^bg " "$CACHE/themes/$theme" | sed 's/.* //')
  cfg=$(grep "^color1 " "$CACHE/themes/$theme" | sed 's/.* //')
  cfc=$(grep "^color11 " "$CACHE/themes/$theme" | sed 's/.* //')
  nfg=$(grep "^color4 " "$CACHE/themes/$theme" | sed 's/.* //')
  lfg=$(grep "^color7 " "$CACHE/themes/$theme" | sed 's/.* //')
  [ -z "$bg" ] && { echo "${Err}Error parsing the background color${Off}"; exit 1; }
  [ -z "$cfc" ] && { echo "${Err}Error parsing the frame color${Off}"; exit 1; }
  [ -z "$cfg" ] && { echo "${Err}Error parsing the critical foreground color${Off}"; exit 1; }
  [ -z "$nfg" ] && { echo "${Err}Error parsing the normal foreground color${Off}"; exit 1; }
  [ -z "$lfg" ] && { echo "${Err}Error parsing the low foreground color${Off}"; exit 1; }

  sed -i "s/\(\s\+background\s\+=\s\+\"\)#......\(\"  # URGENCY_CRITICAL BG\)/\1$bg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+background\s\+=\s\+\"\)#......\(\"  # URGENCY_NORMAL BG\)/\1$bg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+background\s\+=\s\+\"\)#......\(\"  # URGENCY_LOW BG\)/\1$bg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+foreground\s\+=\s\+\"\)#......\(\"  # URGENCY_CRITICAL FG\)/\1$cfg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+foreground\s\+=\s\+\"\)#......\(\"  # URGENCY_NORMAL FG\)/\1$nfg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+foreground\s\+=\s\+\"\)#......\(\"  # URGENCY_LOW FG\)/\1$lfg\2/" "$DUNSTRC"
  sed -i "s/\(\s\+frame_color\s\+=\s\+\"\)#......\(\"  # URGENCY_CRITICAL FC\)/\1$cfc\2/" "$DUNSTRC"

  killall dunst
  dunst -conf "$DUNSTRC" &
  dunstify "$(echo $theme | sed 's/.conf$//')" "this is an error" -u critical -t 10000
  dunstify "$(echo $theme | sed 's/.conf$//')" "this is normal" -u normal -t 10000
  dunstify "$(echo $theme | sed 's/.conf$//')" "this is nothing" -u low -t 10000
}

main "$@"
