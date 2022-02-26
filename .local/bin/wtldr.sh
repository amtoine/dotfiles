#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __         _ _      _         _
#      ___   / / __ __ _| | |_ __| |_ _  __| |_
#     (_-<  / /  \ V  V / |  _/ _` | '_|(_-< ' \
#     /__/ /_/    \_/\_/|_|\__\__,_|_|(_)__/_||_|
#
# Description:  an fzf wrapper around tldr for those who, like me, do not really know what there is
#               on tldr.
#               adapted from https://hiphish.github.io/blog/2020/05/31/macho-man-command-on-steroids
# Dependencies: fzf, tldr
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

export FZF_DEFAULT_OPTS='
--height=100%
--layout=reverse
--prompt="TL;DR: "
--preview="echo {1} | xargs -I{S} tldr {S} 2>/dev/null"'

help () {
  #
  # the help function.
  #
  echo "macho.sh:"
  echo "     This script allows the user to easily search tldr pages with fzf."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     wltdr.sh [-h]"
  echo ""
  echo "Switches:"
  echo "     -h         show this help."
  exit 0
}

main () {
  while getopts "h" opt; do
      case "$opt" in
          h ) help;;
          \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
          : ) echo "Option -$OPTARG requires an argument" >&2; exit 1;;
      esac
  done

  help=$(
    tldr -l | \
    tr , '\n' | \
    sed "s/'//g; s/'//; s/\[//; s/\]//; s/ //g" | \
    sort | \
    fzf
  )
  [ -z "$help" ] && exit 0
  tldr "$help"
}

main "$@"
