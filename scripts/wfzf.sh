#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __          __     __     _
#      ___   / / __ __ __/ _|___/ _| __| |_
#     (_-<  / /  \ V  V /  _|_ /  _|(_-< ' \
#     /__/ /_/    \_/\_/|_| /__|_|(_)__/_||_|
#
# Description:  changes all your wallpapers in one command, with fzf.
#               adapted from https://hiphish.github.io/blog/2020/05/31/macho-man-command-on-steroids
# Dependencies: amixer, ~/scripts/bluetooth.toggle.sh
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o h --long help -n 'wfzf.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# environment variables
[[ ! -v WALLPAPERS ]] && WALLPAPERS="$HOME/repos/wallpapers/wallpapers"

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
  echo ""
  echo "Environment variables:"
  echo "     WALLPAPERS        the path to the wallpapers (defaults to '\$HOME/repos/wallpapers/wallpapers')"
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

  wallpapers=()
  for x in $(xrandr --query | grep -e "\<connected" | sed 's/ connected.*//');
  do
    wallpaper=$(
      ls "$WALLPAPERS" | \
      fzf --prompt="Please choose a wallpaper for $x: "
    )
    [ -z "$wallpaper" ] && exit 0
    wallpapers+=("$WALLPAPERS/$wallpaper")
  done
  feh --bg-fill "${wallpapers[@]}"
}

main "$@"
