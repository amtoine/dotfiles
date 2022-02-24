#!/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __         _ _      _
#      ___   / / __ ____| | |  __| |_
#     (_-<  / /  \ V / _` | |_(_-< ' \
#     /__/ /_/    \_/\__,_|_(_)__/_||_|
#
# Description:  updates some lists of installed packages.
# Dependencies: pacman, comm
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o ah --long audio,help -n 'vdl.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# environment variables
[[ ! -v QUALITY ]] && QUALITY="480"

usage () {
  #
  # the usage function.
  #
  echo "Usage: vdl.sh [-a] URL"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "hdmi.sh:"
  echo "     This script allows the user to easily download videos from youtube.com"
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     vdl.sh [-a] URL"
  echo ""
  echo "Switches:"
  echo "     -h/--help               shows this help."
  echo "     -a/--audio              download the audio only"
  echo ""
  echo "Environment variables:"
  echo "     QUALITY                 the quality of the video to be downloaded (defaults to '480')"
  exit 0
}

main () {
  ACTION="video"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help )      help ;;
      -a | --audio )     ACTION="audio"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
  [ -z "$1" ] && usage
  case "$ACTION" in
    audio )  youtube-dl --format "bestaudio[ext=m4a]" --extract-audio "$1" ;;
    video )  youtube-dl --format "bestvideo[ext=mp4][height<=?$QUALITY]+bestaudio[ext=m4a]" "$1" ;;
    * ) echo "an error occured (got unexpected '$ACTION')"; exit 1 ;;
  esac
}

main "$@"
