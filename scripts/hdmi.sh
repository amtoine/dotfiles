#! /usr/bin/bash
TEMP=$(getopt -o b:dlmr --long brightness:,disconnect,left,mirror,right \
              -n 'hdmi.sh' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$TEMP"

[[ ! -v MAIN_DISPLAY ]] && MAIN_DISPLAY="eDP-1"
[[ ! -v SECOND_MONITOR ]] && SECOND_MONITOR="HDMI-2"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -b | --brightness ) xrandr --output $SECOND_MONITOR --brightness "$2"; exit 0 ;;
    -d | --disconnect ) xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --off; exit 0 ;;
    -l | --left )       xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --mode 1920x1080 --rate 60 --left-of  $MAIN_DISPLAY; exit 0 ;;
    -m | --mirror )     xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --mode 1920x1080 --rate 60 --same-as  $MAIN_DISPLAY; exit 0 ;;
    -r | --right )      xrandr --output $MAIN_DISPLAY --auto --output $SECOND_MONITOR --mode 1920x1080 --rate 60 --right-of $MAIN_DISPLAY; exit 0 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done
