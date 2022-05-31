#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#             __           _      _
#      ___   / / __ ____ _| |  __| |_
#     (_-<  / /  \ \ / _` | |_(_-< ' \
#     /__/ /_/   /_\_\__,_|_(_)__/_||_|
#
# Description:  wraps the xautolock command with some notifications.
# Dependencies: xautolock, dunst
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o hedn --long help,nable,disable,notify \
              -n 'xal.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# environment variables
[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"

usage () {
  #
  # the usage function.
  #
  echo "Usage: xal.sh [-hedn]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "xal.sh:"
  echo "     This script allows the user to easily toggle xautolock."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     xal.sh [-hedn]"
  echo ""
  echo "Switches:"
  echo "     -h/--help               shows this help."
  echo "     -e/--enable             enable the xautolock"
  echo "     -d/--disable            disable the xautolock"
  echo "     -n/--notify             enable notifications"
  echo ""
  echo "Environment variables:"
  echo "     ICONS                   the path the the icons (defaults to '/usr/share/icons/a2n-s-icons')"
  exit 0
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help )      help ;;
      -e | --enable)   ACTION="enable"; shift 1 ;;
      -d | --disable ) ACTION="disable"; shift 1 ;;
      -n | --notify )  NOTIFY="yes"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
  [ -z "$ACTION" ] && usage
  case "$ACTION" in
    disable ) xautolock -disable; [[ "$NOTIFY" == "yes" ]] && dunstify "xal.sh" "xautolock disabled" --icon="$ICONS/lock-unlocked.png" ;;
    enable) xautolock -enable; [[ "$NOTIFY" == "yes" ]] && dunstify "xal.sh" "xautolock enabled" --icon="$ICONS/lock-locked.png" ;;
    * ) echo "an error occured (got unexpected '$ACTION')" ;;
  esac
}

main "$@"
