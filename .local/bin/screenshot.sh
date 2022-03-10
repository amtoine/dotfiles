#!/bin/sh
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                             _        _        _
#      ___   / /  ___ __ _ _ ___ ___ _ _  __| |_  ___| |_   __| |_
#     (_-<  / /  (_-</ _| '_/ -_) -_) ' \(_-< ' \/ _ \  _|_(_-< ' \
#     /__/ /_/   /__/\__|_| \___\___|_||_/__/_||_\___/\__(_)__/_||_|
#
# Description:  takes a screenshot of all the screens with the 'full' flag and only a selected window with the 'window' flag.
#               '$SCRIPTS/screenshot.sh full' will take a screenshot of the whole screen.
#               '$SCRIPTS/screenshot.sh window' will let the user chose the window he wants to take a screenshot of.
# Dependencies: scrot
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments.
OPTIONS=$(getopt -o h --long help -n 'screenshot.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# the environment variables
[[ ! -v SHOTS ]] && SHOTS="$HOME/imgs/shots"
[[ ! -v FORMAT ]] && FORMAT='%Y-%m-%d_%H-%M-%S_$wx$h_scrot'

usage () {
  #
  # the usage function.
  #
  echo "Usage: screenshot.sh [-h] METHOD"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "screenshot.sh:"
  echo "     This script takes screenshot of either a window or the whole screen."
  echo "     (see the METHOD section)"
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     screenshot.sh [-h] METHOD"
  echo ""
  echo "Switches:"
  echo "     -h/--help   shows this help."
  echo ""
  echo "METHOD:"
  echo "the \`screenshot.sh\` script allows two methods:"
  echo "     - the \`window\` method which lets the user click a window to take a photo of."
  echo "     - the \`full\` method that takes a picture of the entire monitors."
  echo ""
  echo "Environment variables:"
  echo "     SHOTS       the place where to store screenshots (defaults to '~/imgs/shots')"
  echo "     FORMAT      the format for the filenames (defaults to '%Y-%m-%d_%H-%M-%S_\$wx\$h_scrot')"
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

	case "$1" in
	full)
		scrot -m "$FORMAT.png" -e "mv \$f $SHOTS"
		;;
	window)
		scrot -s "$FORMAT.png" -e "mv \$f $SHOTS"
		;;
	*) usage
		;;
	esac;
}

main "$@"
