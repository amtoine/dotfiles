#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                          _
#      ___   / /  ___ _ __  ___ _ _    __| |_
#     (_-<  / /  / _ \ '_ \/ -_) ' \ _(_-< ' \
#     /__/ /_/   \___/ .__/\___|_||_(_)__/_||_|
#                    |_|
#
# Description:  tries to replace a tiny part of xdg-open as it does not behave as I want.
# Dependencies: kitty, feh, okular
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments.
OPTIONS=$(getopt -o h --long help -n 'open.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# the environment variables
[[ ! -v TERMINAL ]] && TERMINAL="kitty"
[[ ! -v BROWSER ]] && BROWSER="surf"

usage () {
  #
  # the usage function.
  #
  echo "Usage: open.sh [-h] FILE/URL"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "open.sh:"
  echo "     This script opens files and urls automatically."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     open.sh [-h] FILE/URL"
  echo ""
  echo "Switches:"
  echo "     -h/--help       shows this help."
  echo ""
  echo "Environment variables:"
  echo "     TERMINAL        the terminal to use (defaults to 'kitty')"
  echo "     BROWSER         the browser to use (defaults to 'surf')"
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
  [[ "$1" =~ http* ]] && { "$BROWSER" "$1"; exit 0; }

  [ -z "$ACTION" ] && usage
  case $(file --mime-type $1 -b) in
    text/*) $TERMINAL $EDITOR "$1";;
    image/*) feh $1;;
    */pdf) $TERMINAL okular "$1";;
    *) exit 1;;
  esac
}

main "$@"
