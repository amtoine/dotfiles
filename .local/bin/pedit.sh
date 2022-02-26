#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __               _ _ _        _
#      ___   / /  _ __  ___ __| (_) |_   __| |_
#     (_-<  / /  | '_ \/ -_) _` | |  _|_(_-< ' \
#     /__/ /_/   | .__/\___\__,_|_|\__(_)__/_||_|
#                |_|
#
# Description:  edit a pass entry with dmenu
# Dependencies: kitty, feh, okular
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments.
OPTIONS=$(getopt -o h --long help -n 'pedit.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# the environment variables
[[ ! -v DMFONT ]] && DMFONT="mononoki Nerd Font-20"
[[ ! -v PEDITOR ]] && PEDITOR="emacs"

help () {
  #
  # the help function.
  #
  echo "pedit.sh:"
  echo "     This script searches and edits \`pass\` entries."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     pedit.sh [-h]"
  echo ""
  echo "Switches:"
  echo "     -h/--help       shows this help."
  echo ""
  echo "Environment variables:"
  echo "     DMFONT        the font to user for \`dmenu\` (defaults to 'mononoki Nerd Font-20')"
  echo "     PEDITOR       the text editor to use (defaults to 'emacs')"
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

  pass_entry=$(
    find ~/.password-store/ -type f -not -path "*/.git*" | \
    sed "s|$HOME\/\.password-store||; s/\.gpg//" | \
    dmenu -c -l 10 -bw 5 -p "Please choose a pass entry to edit:" -fn "$DMFONT"
  )
  [ -z "$pass_entry" ] && exit 0

  EDITOR="$PEDITOR" pass edit "$pass_entry"
}

main "$@"
