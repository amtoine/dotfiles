#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#        _     __  _        __          __     __     _
#       | |   / / | |__    / / __ __ __/ _|___/ _| __| |_
#      _| |  / /  | '_ \  / /  \ V  V /  _|_ /  _|(_-< ' \
#     (_)_| /_/   |_.__/ /_/    \_/\_/|_| /__|_|(_)__/_||_|
#
# Description:  changes all your wallpapers in one command, with fzf.
#               adapted from https://hiphish.github.io/blog/2020/05/31/macho-man-command-on-steroids
# Dependencies: amixer, ~/scripts/bluetooth.toggle.sh, polybar
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o hdr --long help,dmenu,rofi -n 'wfzf.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# environment variables
[[ ! -v WALLPAPERS ]] && WALLPAPERS="/usr/share/backgrounds"

export FZF_DEFAULT_OPTS="
--height=100%
--layout=reverse
--preview-window=\"down,75%\"
--preview=\"catimg $WALLPAPERS/{1} -H 100 -r 2\""

help () {
  #
  # the help function.
  #
  echo "wfzf.sh:"
  echo "     This script allows the user to easily switch wallpapers"
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     wfzf.sh [-h]"
  echo ""
  echo "Switches:"
  echo "     -h/--help         shows this help."
  echo "     -d/--dmenu        uses dmenu instead of fzf."
  echo "     -r/--rofi         uses rofi instead of fzf."
  echo ""
  echo "Environment variables:"
  echo "     WALLPAPERS        the path to the wallpapers (defaults to '/usr/share/backgrounds')"
  exit 0
}

main () {
  command="fzf --prompt"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -d | --dmenu ) command="dmenu -c -l 20 -bw 5 -p"; break ;;
      -r | --rofi ) command="rofi -dmenu -c -l 20 -bw 5 -p"; break ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  monitors=$(polybar -m | awk -F: '{print $1}')
  nb_monitors=$(wc -l <<< "$monitors")
  wallpapers=()
  for x in $monitors;
  do
    wallpaper=$(
      {
        grep "feh" ~/.fehbg | awk -v nm="$nb_monitors" -F" " '{ for (i = 4; i < 4 + nm; i++) print $i; }' | sed "s/'//g;";
        find "$WALLPAPERS" -type f | sort;
      } | sed "s|$WALLPAPERS/||g" |\
      $command "Wallpaper for $x: "
    )
    [ -z "$wallpaper" ] && exit 0
    wallpapers+=("$WALLPAPERS/$wallpaper")
  done
  feh --bg-fill "${wallpapers[@]}"
}

main "$@"
