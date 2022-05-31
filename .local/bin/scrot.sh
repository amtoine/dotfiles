#!/bin/sh
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                 _        _
#      ___   / /  ___ __ _ _ ___| |_   __| |_
#     (_-<  / /  (_-</ _| '_/ _ \  _|_(_-< ' \
#     /__/ /_/   /__/\__|_| \___/\__(_)__/_||_|
#
# Description:  takes a screenshot of all the screens with the 'full' flag and only a selected window with the 'window' flag.
#               '$SCRIPTS/screenshot.sh full' will take a screenshot of the whole screen.
#               '$SCRIPTS/screenshot.sh window' will let the user chose the window he wants to take a screenshot of.
# Dependencies: scrot
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments.
OPTIONS=$(getopt -o hn --long help,notify -n 'scrot.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# the environment variables
[[ ! -v SHOTS ]] && SHOTS="$HOME/imgs/shots"
[[ ! -v FORMAT ]] && FORMAT='scrot_%Y-%m-%d_%H-%M-%S_$wx$h'
[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"

usage () {
  #
  # the usage function.
  #
  echo "Usage: scrot.sh [-hn] METHOD"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "scrot.sh:"
  echo "     This script takes screenshot of either a window or the whole screen."
  echo "     (see the METHOD section)"
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     scrot.sh [-hn] METHOD"
  echo ""
  echo "Switches:"
  echo "     -h/--help               shows this help."
  echo "     -n/--notify             enable notifications"
  echo ""
  echo "METHOD:"
  echo "the \`scrot.sh\` script allows two methods:"
  echo "     - the \`window\` method which lets the user click a window to take a photo of."
  echo "     - the \`full\` method that takes a picture of the entire monitors."
  echo ""
  echo "Environment variables:"
  echo "     SHOTS       the place where to store screenshots (defaults to '~/imgs/shots')"
  echo "     FORMAT      the format for the filenames (defaults to 'scrot_%Y-%m-%d_%H-%M-%S_\$wx\$h')"
  echo "     ICONS       the path the the icons (defaults to '/usr/share/icons/a2n-s-icons')"
  exit 0
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -n | --notify ) NOTIFY="yes"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

	case "$1" in
	full)
		name=$(scrot -m "$FORMAT.png" -e "echo \$f; mv \$f $SHOTS");
		;;
	window)
    [ -v NOTIFY ] && dunstify "scrot.sh" "please select a window" --icon="$ICONS/camera.png";
		name=$(scrot -s "$FORMAT.png" -e "echo \$f; mv \$f $SHOTS");
		;;
	*) usage
		;;
	esac;

  echo "name: $name"
  [ -n "$name" ] && [ -v NOTIFY ] && dunstify "scrot.sh" "$1 screenshot at\n$name" --icon="$ICONS/camera.png"
}

main "$@"
