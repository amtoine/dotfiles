#!/usr/bin/env bash
#           ___
#      __ _|_  )_ _ ___ ___   personal page: https://a2n-s.github.io/
#     / _` |/ /| ' \___(_-<   github   page: https://github.com/a2n-s
#     \__,_/___|_||_|  /__/   my   dotfiles: https://github.com/a2n-s/dotfiles
#        _     __  _        __                _      _            _
#       | |   / / | |__    / /  _  _ _ __  __| |__ _| |_ ___   __| |_
#      _| |  / /  | '_ \  / /  | || | '_ \/ _` / _` |  _/ -_)_(_-< ' \
#     (_)_| /_/   |_.__/ /_/    \_,_| .__/\__,_\__,_|\__\___(_)__/_||_|
#                                   |_|
# Description:  a tool to check and update the system.
# Dependencies: dunst.
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o hcu --long help,check,update \
              -n 'update.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# environment variables
[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"
[[ ! -v TERMINAL ]] && TERMINAL="st -e"

check_updates () {
  # Check the system for updates.
  dunstify "update.sh" "pulling updates..."
  updates=$(checkupdates | wc -l)
  if [ "$updates" -eq "0" ]; then
    dunstify "update.sh" "everything is up to date!" --icon="$ICONS/ok.png"
  else
    dunstify "update.sh" "there are $updates updates." --icon="$ICONS/package.png"
  fi
}

update () {
  # Update the system with pacman in a popup terminal.
  dunstify "update.sh" "please confirm your password in the popup window" --icon="$ICONS/lock-locked.png"
  $TERMINAL sudo pacman -Syyu
  dunstify "update.sh" "update did complete successfully" --icon="$ICONS/lock-unlocked.png"
  check_updates
}

usage () {
  #
  # the usage function.
  #
  echo "Usage: update.sh [-hcu]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "update.sh:"
  echo "     a tool to check and update the system."
  echo ""
  echo "Usage:"
  echo "     update.sh [-hcu]"
  echo ""
  echo "Switches:"
  echo "     -h/--help             shows this help."
  echo "     -c/--check            check for system updates."
  echo "     -u/--update           update the system."
  echo ""
  echo "Environment variables:"
  echo "     ICONS                   the path the the icons (defaults to '/usr/share/icons/a2n-s-icons')"
  echo "     TERMINAL                the terminal to update the system (defaults to 'st -e')"
  exit 0
}
main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help )    help ;;
      -c | --check )   ACTION="check"; shift 1 ;;
      -u | --update )  ACTION="update"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  # an action is required
  [ -z "$ACTION" ] && usage
  case "$ACTION" in
    check ) check_updates ;;
    update ) update ;;
    * ) echo "an error occured (got unexpected '$ACTION')"; exit 1 ;;
  esac
}

main "$@"
