#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                          _        _
#      ___   / /  _ __ _ _ ___ _ __  _ __| |_   __| |_
#     (_-<  / /  | '_ \ '_/ _ \ '  \| '_ \  _|_(_-< ' \
#     /__/ /_/   | .__/_| \___/_|_|_| .__/\__(_)__/_||_|
#                |_|                |_|
#
# Description:  a dmenu binary prompt inspired by https://www.youtube.com/watch?v=R9m723tAurA 
#               Gives a dmenu prompt labeled with $1 and ask to perform command $2.

#               For example:
#               ~/scripts/prompt "Do you really want to shutdown your machine?" "shutdown -h now"
#               will ask you before shutting down.
# Dependencies: dmenu
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments.
OPTIONS=$(getopt -o h --long help -n 'prompt.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# the environment variables
[[ ! -v DMFONT ]] && DMFONT="mononoki Nerd Font-20"

usage () {
  #
  # the usage function.
  #
  echo "Usage: prompt.sh [-h] MESSAGE COMMAND"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "pedit.sh:"
  echo "     This script opens a binary prompt to launch or discard applications."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     prompt.sh [-h] MESSAGE COMMAND"
  echo ""
  echo "Switches:"
  echo "     -h/--help       shows this help."
  echo ""
  echo "Environment variables:"
  echo "     DMFONT          the font to user for \`dmenu\` (defaults to 'mononoki Nerd Font-20')"
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

  [ -z "$1" ] && usage
  [ -z "$2" ] && usage
  [[ $(echo -e "No\nYes" | dmenu -i -p "$1" -fn "$DMFONT") == "Yes" ]] && "$2"
}

main "$@"
