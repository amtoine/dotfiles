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

OPTIONS=$(getopt -o edn --long enable,disable,notify \
              -n 'xal.sh' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$OPTIONS"

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -e | --enable)   ACTION="enable"; shift 1 ;;
      -d | --disable ) ACTION="disable"; shift 1 ;;
      -n | --notify )  NOTIFY="yes"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
  case "$ACTION" in
    disable ) xautolock -disable; [[ "$NOTIFY" == "yes" ]] && dunstify "xal.sh" "xautolock disabled" ;;
    enable) xautolock -enable; [[ "$NOTIFY" == "yes" ]] && dunstify "xal.sh" "xautolock enabled" ;;
    * ) echo "an error occured (got unexpected '$ACTION')" ;;
  esac
}

main "$@"
