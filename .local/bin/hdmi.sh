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
OPTIONS=$(getopt -o b:dlmrMSnhw --long brightness:,disconnect,left,mirror,right,main,second,notify,restart-wm,help \
              -n 'hdmi.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# the environment variables
[ ! -v MAIN ] && MAIN="eDP-1"
[ ! -v SECOND ] && SECOND="HDMI-2"

change_brightness () {
  SIDE="$2"
  STEP="$3" # Step Up/Down brightness by: 5 = ".05", 10 = ".10", etc.

  if [[ ! "$SIDE" == +* ]] && [[ ! "$SIDE" == -* ]]; then
    xrandr --output "$1" --brightness "$SIDE"
    return
  fi

  CurrBright=$(xrandr --verbose --current | grep ^"$1" -A5 | tail -n1 )
  CurrBright="${CurrBright##* }"  # Get brightness level with decimal place

  Left=${CurrBright%%"."*}        # Extract left of decimal point
  Right=${CurrBright#*"."}        # Extract right of decimal point

  MathBright="0"
  [[ "$Left" != 0 && "$STEP" -lt 10 ]] && STEP=10     # > 1.0, only .1 works
  [[ "$Left" != 0 ]] && MathBright="$Left"00          # 1.0 becomes "100"
  [[ "${#Right}" -eq 1 ]] && Right="$Right"0          # 0.5 becomes "50"
  MathBright=$(( MathBright + Right ))

  [[ "$SIDE" == "Up" || "$SIDE" == "+" ]] && MathBright=$(( MathBright + STEP ))
  [[ "$SIDE" == "Down" || "$SIDE" == "-" ]] && MathBright=$(( MathBright - STEP ))
  [[ "${MathBright:0:1}" == "-" ]] && MathBright=0    # Negative not allowed
  [[ "$MathBright" -gt 110  ]] && MathBright=110      # Can't go over 1.10

  case "${#MathBright}" in
    3) MathBright="$MathBright"
       CurrBright="${MathBright:0:1}.${MathBright:1:2}"
    ;;
    1) MathBright=0"$MathBright"
       CurrBright=".${MathBright:0:2}"
    ;;
    *) MathBright="$MathBright"
       CurrBright=".${MathBright:0:2}"
    ;;
  esac

  xrandr --output "$1" --brightness "$CurrBright"   # Set new brightness
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
  dunstify "Brightness ($1)" -h "int:value:$2" -u low
}

usage () {
  #
  # the usage function.
  #
  echo "Usage: hdmi.sh [-hdlmrMSn] [-b BRIGHTNESS/DELTA]"
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
  echo "     hdmi.sh [-hdlmrMSn] [-b BRIGHTNESS/DELTA]"
  echo ""
  echo "Switches:"
  echo "     -h/--help               shows this help."
  echo "     -b/--brightness         change the brightness of the selected monitor (see -M and -S to select a monitor)."
  echo "                             requires one positional argument after -b."
  echo "                               the MAIN monitor uses \`brightnessctl\` and thus accepts arguments such as 123 or 16-"
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
  echo "     MAIN        the name of the main monitor (defaults to 'eDP-1')"
  echo "     SECOND      the name of the main monitor (defaults to 'HDMI-2')"
  exit 0
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help )       help ;;
      -b | --brightness ) ACTION="brightness"; BRIGHTNESS="$2"; shift 2 ;;
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
      if [ "$MONITOR" = "$MAIN" ]; then
        brightnessctl s "$BRIGHTNESS"
        [ -v NOTIFY ] && notify_brightness "$MONITOR" $(brightnessctl | grep "Current" | sed 's/.*Current.*(\(.*\)%)/\1/')
      elif [ "$MONITOR" = "$SECOND" ]; then
        change_brightness "$MONITOR" "$BRIGHTNESS" 2
        CurrBright=$(xrandr --verbose --current | grep ^"$MONITOR" -A5 | tail -n1 | sed 's/.*Brightness: \(.*\)/\1/' )
        CurrBright=$(awk -vb="$CurrBright" 'BEGIN{printf "%.2f" ,b * 100}')
        [ -v NOTIFY ] && notify_brightness "$MONITOR" "$CurrBright"
      else
        echo "no monitor selected"
      fi
      exit 0
      ;;
    disconnect ) xrandr --output "$MAIN" --auto --output "$SECOND" --off; [ -v WM ] && wm_restart; [ -v NOTIFY ] && dunstify "hdmi.sh" "$SECOND disconnected" ;;
    left )       connect "$MAIN" "$SECOND" "left-of"; [ -v WM ] && wm_restart;  [ -v NOTIFY ] && dunstify "hdmi.sh" "$SECOND is now on the left of $MAIN" ;;
    mirror )     connect "$MAIN" "$SECOND" "same-as"; [ -v WM ] && wm_restart;  [ -v NOTIFY ] && dunstify "hdmi.sh" "$SECOND is now the same as $MAIN" ;;
    right )      connect "$MAIN" "$SECOND" "right-of"; [ -v WM ] && wm_restart; [ -v NOTIFY ] && dunstify "hdmi.sh" "$SECOND is now on the right of $MAIN" ;;
    * ) echo "an error occured (got unexpected '$ACTION')"; [ -v NOTIFY ] && dunstify "hdmi.sh" "an error occured (got unexpected '$ACTION')"; break ;;
  esac
}

main "$@"
