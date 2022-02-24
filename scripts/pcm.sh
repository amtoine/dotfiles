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

OPTIONS=$(getopt -o tbn --long toggle,blur,notify \
              -n 'pcm.sh' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$OPTIONS"

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -t | --toggle ) ACTION="toggle"; shift 1 ;;
      -b | --blur )   ACTION="blur"; shift 1 ;;
      -n | --notify ) NOTIFY="yes"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
  case "$ACTION" in
    toggle ) 
      if pgrep -x "picom" > /dev/null
      then
        killall picom
        [[ "$NOTIFY" == "yes" ]] && dunstify "pcm.sh" "picom killed"
      else
        picom --experimental-backends -b
        [[ "$NOTIFY" == "yes" ]] && dunstify "pcm.sh" "picom started"
      fi;;
    blur )
      if grep "^#blur-method" ~/.config/picom/picom.conf > /dev/null
      then
        sed -i 's/^#\?blur-method/blur-method/' ~/.config/picom/picom.conf
        [[ "$NOTIFY" == "yes" ]] && dunstify "pcm.sh" "blur ON"
      else
        sed -i 's/^#\?blur-method/#blur-method/' ~/.config/picom/picom.conf
        [[ "$NOTIFY" == "yes" ]] && dunstify "pcm.sh" "blur OFF"
      fi;;
    * ) echo "an error occured (got unexpected '$ACTION')" ;;
  esac
}

main "$@"
