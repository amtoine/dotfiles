#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                _             _
#      ___   / /  _ __  __ _ __| |_  ___   __| |_
#     (_-<  / /  | '  \/ _` / _| ' \/ _ \_(_-< ' \
#     /__/ /_/   |_|_|_\__,_\__|_||_\___(_)__/_||_|
#
# Description:  gives a complete overview of all the active repos on the system.
#               inpired from https://hiphish.github.io/blog/2020/05/31/macho-man-command-on-steroids
# Dependencies: man, fzf
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

export FZF_DEFAULT_OPTS='
--height=100%
--layout=reverse
--prompt="Manual: "
--preview="echo {1} | sed -E \"s/^\((.+)\)/\1/\" | xargs -I{S} man -Pcat {S} {2} 2>/dev/null"'

help () {
  #
  # the help function.
  #
  echo "macho.sh:"
  echo "     This script allows the user to easily search man pages with fzf."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     macho.sh [-h] [-s SECTION]"
  echo ""
  echo "Switches:"
  echo "     -h         show this help."
  echo "     -s         select a particular section to search from amongst man pages."
  exit 0
}

main () {
  while getopts ":s:h" opt; do
      case "$opt" in
          h ) help;;
          s ) SECTION=$OPTARG; shift 2;;
          \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
          : ) echo "Option -$OPTARG requires an argument" >&2; exit 1;;
      esac
  done

  manual=$(apropos -s ${SECTION:-''} ${@:-.} | \
    grep -v -E '^.+ \(0\)' |\
    awk '{print $2 "    " $1}' | \
    sort | \
    fzf | \
    sed 's/^(.*)\s\+//' \
  )

  [ -z "$manual" ] && exit 0
  man "$manual"
}

main "$@"
