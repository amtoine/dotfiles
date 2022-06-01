#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#             __                      _
#      ___   / /  _ __  __ _ __    __| |_
#     (_-<  / /  | '_ \/ _| '  \ _(_-< ' \
#     /__/ /_/   | .__/\__|_|_|_(_)__/_||_|
#                |_|
#
# Description:  wraps the picom compositor with some notifications.
# Dependencies: picom, dunst
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

# parse the arguments.
OPTIONS=$(getopt -o tbnh --long toggle,blur,notify,help -n 'pcm.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# environment variables
[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"

usage () {
  #
  # the usage function.
  #
  echo "Usage: pcm.sh [-htbn]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "pcm.sh:"
  echo "     This script allows the user to easily manage picom."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     pcm.sh [-htbn]"
  echo ""
  echo "Switches:"
  echo "     -h/--help       shows this help."
  echo "     -t/--toggle     toggle picom ON and OFF"
  echo "     -b/--blur       toggle picom's blur effect on transparent windows"
  echo "     -n/--notify     enable notifications"
  echo ""
  echo "Environment variables:"
  echo "     ICONS           the path the the icons (defaults to '/usr/share/icons/a2n-s-icons')"
  exit 0
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -t | --toggle ) ACTION="toggle"; shift 1 ;;
      -b | --blur )   ACTION="blur"; shift 1 ;;
      -n | --notify ) NOTIFY="yes"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
  [ -z "$ACTION" ] && usage
  case "$ACTION" in
    toggle ) 
      if pgrep -x "picom" > /dev/null
      then
        killall picom
        [[ "$NOTIFY" == "yes" ]] && dunstify "pcm.sh" "picom killed" --icon="$ICONS/video-compositor-off.png"
      else
        picom --experimental-backends -b
        [[ "$NOTIFY" == "yes" ]] && dunstify "pcm.sh" "picom started" --icon="$ICONS/video-compositor-off.png"
      fi;;
    blur )
      if grep "^#blur-method" ~/.config/picom/picom.conf > /dev/null
      then
        sed -i 's/^#\?blur-method/blur-method/' ~/.config/picom/picom.conf
        [[ "$NOTIFY" == "yes" ]] && dunstify "pcm.sh" "blur ON" --icon="$ICONS/video-blur-on.png"
      else
        sed -i 's/^#\?blur-method/#blur-method/' ~/.config/picom/picom.conf
        [[ "$NOTIFY" == "yes" ]] && dunstify "pcm.sh" "blur OFF" --icon="$ICONS/video-blur-off.png"
      fi;;
    * ) echo "an error occured (got unexpected '$ACTION')" ;;
  esac
}

main "$@"
