#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#             __  _       _       _      _
#      ___   / / | |_  __| |_ __ (_)  __| |_
#     (_-<  / /  | ' \/ _` | '  \| |_(_-< ' \
#     /__/ /_/   |_||_\__,_|_|_|_|_(_)__/_||_|
#
# Description:  manages hdmi monitors, increases or decreases the brightness of the screen by giving + or - to the script.
#               one can use multiple flags, only the last one will be used.
# Dependencies: xrandr
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: WinEunuuchs2Unix at https://askubuntu.com/questions/1150339/increment-brightness-by-value-using-xrandr (original idea)
#               Stevan Antoine (adaptations)

# parse the arguments.
OPTIONS=$(getopt -o b:s:dlmrMSnhw --long brightness:,step:,disconnect,left,mirror,right,main,second,notify,restart-wm,help \
              -n 'hdmi.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# the environment variables
[ ! -v MAIN ] && MAIN="eDP-1"
[ ! -v SECOND ] && SECOND="HDMI-2"
[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"
[ -z "$DUNST_ID" ] && DUNST_ID=5


get_curr_bright() {
  curr_bright=$(xrandr --verbose --current | grep ^"$1" -A5 | tail -n1 | sed 's/.*Brightness: \(.*\)/\1/' )
  curr_bright=$(awk -vb="$curr_bright" 'BEGIN{printf "%.2f" ,b * 100}')
  echo "$curr_bright"
}

change_brightness () {
  SIDE="$2"
  STEP="$3"

  # force set the brightness if there is no `+/-` before the value.
  if [[ ! "$SIDE" == +* ]] && [[ ! "$SIDE" == -* ]]; then
    xrandr --output "$1" --brightness "$SIDE"
    return
  fi

  # get the current brightness.
  curr_bright="$(get_curr_bright "$1")"

  # add the step in the right direction.
  new_bright="$(awk -v c="$curr_bright" -v s="$SIDE$STEP" 'BEGIN {print c + s}')"

  # clip the brightness between 0 and 100%.
  if [ "$new_bright" -lt 0 ]; then
    new_bright=0
  elif [ "$new_bright" -gt 100 ]; then
    new_bright=100
  fi

  # divide by 100 to go between 0 and 1.
  final_bright="$(awk -v n="$new_bright" 'BEGIN {print n / 100}')"

  # set the final brightness
  xrandr --output "$1" --brightness "$final_bright"
}

connect () {
  MAIN="$1"
  SECOND="$2"
  METHOD="$3"
  xrandr 1> /dev/null
  xrandr --output "$MAIN" --auto --output "$SECOND" --mode 1920x1080 --rate 60 --"$METHOD"  "$MAIN"
  change_brightness "$SECOND" .2
}

wm_restart () {
  if pgrep qtile &> /dev/null;
  then
    qtile cmd-obj -o cmd -f restart;
    return
  fi
}

notify_brightness () {
  dunstify "hdmi.sh" "Brightness ($1)\n$2" -h "int:value:$2" -u low --icon="$ICONS/video-brightness.png" --replace="$DUNST_ID"
}

usage () {
  #
  # the usage function.
  #
  echo "Usage: hdmi.sh [-hdlmrMSn] [-b BRIGHTNESS/DELTA -s STEP]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "hdmi.sh:"
  echo "     This script allows the user to easily manage hdmi devices."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     hdmi.sh [-hdlmrMSn] [-b BRIGHTNESS/DELTA -s STEP]"
  echo ""
  echo "Switches:"
  echo "     -h/--help               shows this help."
  echo "     -s/--step               the step to change the brightness. Mandatory with the --brightness flag."
  echo "     -b/--brightness         change the brightness of the selected monitor (see -M and -S to select a monitor)."
  echo "                             requires one positional argument after -b."
  echo "                               the MAIN monitor uses \`brightnessctl\` and thus accepts arguments such as + or -"
  echo "                               the SECOND monitor uses \`xrandr\` and thus accepts arguments such as +, - or .7"
  echo "     -d/--disconnect         disconnect the SECOND monitor"
  echo "     -l/--left               connect the SECOND monitor on the left of MAIN"
  echo "     -m/--mirror             connect the SECOND monitor on the right of MAIN"
  echo "     -r/--right              connect the SECOND monitor as a mirror of MAIN"
  echo "     -M/--main               select MAIN as current monitor (see brightness)"
  echo "     -S/--second             select SECOND as current monitor (see brightness)"
  echo "     -n/--notify             enable notifications"
  echo ""
  echo "Environment variables:"
  echo "     MAIN                    the name of the main monitor (defaults to 'eDP-1')"
  echo "     SECOND                  the name of the main monitor (defaults to 'HDMI-2')"
  echo "     ICONS                   the path the the icons (defaults to '/usr/share/icons/a2n-s-icons')"
  echo "     DUNST_ID                the id of the sound notification, to replace them properly (defaults to 5)"
  exit 0
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help )       help ;;
      -s | --step )       ACTION="brightness"; STEP="$2"; shift 2 ;;
      -b | --brightness ) ACTION="brightness"; SIGN="$2"; shift 2 ;;
      -d | --disconnect ) ACTION="disconnect"; shift 1 ;;
      -l | --left )       ACTION="left"; shift 1 ;;
      -m | --mirror )     ACTION="mirror"; shift 1 ;;
      -r | --right )      ACTION="right"; shift 1 ;;
      -M | --main )       MONITOR="$MAIN"; shift 1 ;;
      -S | --second )     MONITOR="$SECOND"; shift 1 ;;
      -n | --notify )     NOTIFY="yes"; shift 1 ;;
      -w | --restart-wm ) WM="yes"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
  [ -z "$ACTION" ] && usage
  case "$ACTION" in
    brightness )
      [ -z "$STEP" ] && usage
      if [ "$MONITOR" = "$MAIN" ]; then
        _STEP="$(awk -v m="$(brightnessctl m)" "BEGIN {print $STEP / 100 * m}")"
        brightnessctl s "$_STEP$SIGN" -e 2
        current_brightness="$(awk -v g="$(brightnessctl g)" -v m="$(brightnessctl m)" 'BEGIN {print 100 * g / m}')"
        [ -v NOTIFY ] && notify_brightness "$MONITOR" "$current_brightness %"
      elif [ "$MONITOR" = "$SECOND" ]; then
        change_brightness "$MONITOR" "$SIGN" "$STEP"
        current_brightness="$(get_curr_bright "$MONITOR" | cut -d. -f1)"
        [ -v NOTIFY ] && notify_brightness "$MONITOR" "$current_brightness %"
      else
        echo "no monitor selected"
        exit 1
      fi
      exit 0
      ;;
    disconnect ) xrandr --output "$MAIN" --auto --output "$SECOND" --off; [ -v WM ] && wm_restart; [ -v NOTIFY ] && dunstify "hdmi.sh" "$SECOND disconnected" --icon="$ICONS/video-monitor-disconnected.png" ;;
    left )       connect "$MAIN" "$SECOND" "left-of"; [ -v WM ] && wm_restart;  [ -v NOTIFY ] && dunstify "hdmi.sh" "$SECOND is now on the left of $MAIN" --icon="$ICONS/video-monitor-left.png" ;;
    mirror )     connect "$MAIN" "$SECOND" "same-as"; [ -v WM ] && wm_restart;  [ -v NOTIFY ] && dunstify "hdmi.sh" "$SECOND is now the same as $MAIN" --icon="$ICONS/video-monitor-mirror.png" ;;
    right )      connect "$MAIN" "$SECOND" "right-of"; [ -v WM ] && wm_restart; [ -v NOTIFY ] && dunstify "hdmi.sh" "$SECOND is now on the right of $MAIN" --icon="$ICONS/video-monitor-right.png" ;;
    * ) echo "an error occured (got unexpected '$ACTION')"; [ -v NOTIFY ] && dunstify "hdmi.sh" "an error occured (got unexpected '$ACTION')"; break ;;
  esac
}

main "$@"
