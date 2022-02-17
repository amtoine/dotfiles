#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __   __        __          _               __
#        _______________(_)___  / /______     _/_/  / /_  ____/ /___ ___  (_)        _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __ \/ __  / __ `__ \/ /        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / / / / /_/ / / / / / / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /_/ /_/\__,_/_/ /_/ /_/_/   (_)  /____/_/ /_/
#                     /_/
#
# Description:  manages hdmi monitors, increases or decreases the brightness of the screen by giving + or - to the script.
# Dependencies: xrandr
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: WinEunuuchs2Unix at https://askubuntu.com/questions/1150339/increment-brightness-by-value-using-xrandr (original idea)
#               Stevan Antoine (adaptations)

OPTIONS=$(getopt -o b:dlmrMS --long brightness:,disconnect,left,mirror,right,main,second \
              -n 'hdmi.sh' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$OPTIONS"

[[ ! -v MAIN ]] && MAIN="eDP-1"
[[ ! -v SECOND ]] && SECOND="HDMI-2"

change_brightness () {
  SIDE="$2"
  STEP="$3" # Step Up/Down brightness by: 5 = ".05", 10 = ".10", etc.

  if [[ ! "$SIDE" == +* ]] && [[ ! "$SIDE" == -* ]]; then
    xrandr --output "$1" --brightness "$SIDE"
    return
  fi

  CurrBright=$( xrandr --verbose --current | grep ^"$1" -A5 | tail -n1 )
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

while [[ $# -gt 0 ]]; do
  case "$1" in
    -M | --main )   MONITOR="$MAIN"; shift 1 ;;
    -S | --second ) MONITOR="$SECOND"; shift 1 ;;
    -b | --brightness )
      if [ "$MONITOR" = "$MAIN" ]; then
        brightnessctl s "$2"
      elif [ "$MONITOR" = "$SECOND" ]; then
        change_brightness "$MONITOR" "$2" 2; exit 0
      else
        echo "no monitor"
      fi
      exit 0
      ;;
    -d | --disconnect ) xrandr --output "$MAIN" --auto --output "$SECOND" --off; exit 0 ;;
    -l | --left )       connect "$MAIN" "$SECOND" "left-of"; exit 0 ;;
    -m | --mirror )     connect "$MAIN" "$SECOND" "same-as"; exit 0 ;;
    -r | --right )      connect "$MAIN" "$SECOND" "right-of"; exit 0 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done
