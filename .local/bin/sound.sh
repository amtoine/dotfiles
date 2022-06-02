#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                       _      _
#      ___   / /  ___ ___ _  _ _ _  __| |  __| |_
#     (_-<  / /  (_-</ _ \ || | ' \/ _` |_(_-< ' \
#     /__/ /_/   /__/\___/\_,_|_||_\__,_(_)__/_||_|
#
# Description:  manages sound and bluetooth sinks.
#               one can use multiple flags, only the last one will be used.
# Dependencies: amixer, ~/scripts/bluetooth.toggle.sh
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o udtmbc:s:nh --long up,down,toggle,bluetooth,channel:,step:,notify,help \
              -n 'sound.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# environment variables
[[ ! -v DEVICE ]] && DEVICE="JBL Xtreme"
[[ ! -v ON ]] && ON="a2dp_sink"
[[ ! -v OFF ]] && OFF="off"
[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"
[ -z "$DUNST_ID" ] && DUNST_ID=2


bluetooth_on () {
    echo "device ($1) on"
    pacmd set-card-profile "$1" $ON
}

bluetooth_off () {
    echo "device ($1) off"
    pacmd set-card-profile "$1" $OFF
}

bluetooth_toggle () {
    CARD=$(pacmd list-cards | grep -B5 "$DEVICE" | head -1 | sed 's/\s\+index: //')
    if pacmd list-cards | grep -B5 "$DEVICE" | grep 'active profile'
    then
        bluetooth_off "$CARD"
    else
        bluetooth_on "$CARD"
    fi
}

notify () {
  _volume=$(amixer sget "$1" | grep 'Right:' | awk -F'[][]' '{ print $2 }' | sed 's/%//')
  dunstify "volume on $1" "$_volume %" -h "int:value:$_volume" -u low --icon="$ICONS/audio-volume.png" --replace "$DUNST_ID"
}
mute_notify () {
  if amixer sget "$1" | grep "\[on\]" > /dev/null; then
    _volume=$(amixer sget "$1" | grep 'Right:' | awk -F'[][]' '{ print $2 }' | sed 's/%//')
    dunstify -u low "$1" "Device unmuted\n$_volume %" -h "int:value:$_volume"  --icon="$ICONS/audio-unmute.png" --replace "$DUNST_ID"
  else
    dunstify -u low "$1" "Device muted"  --icon="$ICONS/audio-mute.png" --replace "$DUNST_ID"
  fi
}
bluetooth_notify () {
  if pacmd list-cards | grep -B5 "$DEVICE" | grep 'active profile'
  then
    dunstify "Bluetooth" "$DEVICE active"  --icon="$ICONS/bluetooth-active.png"
  else
    dunstify "Bluetooth" "$DEVICE disabled"  --icon="$ICONS/bluetooth-disabled.png"
  fi
}

usage () {
  #
  # the usage function.
  #
  echo "Usage: sound.sh [-hudtbn] -c CHANNEL [-s STEP]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "hdmi.sh:"
  echo "     This script allows the user to easily control the sound."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     sound.sh [-hudtbn] -c CHANNEL [-s STEP]"
  echo ""
  echo "Switches:"
  echo "     -h/--help               shows this help."
  echo "     -c/--channel            the channel to control (required)"
  echo "     -s/--step               the step to increase/decrease the volume by, in % (required when no toggle)"
  echo "     -u/--up                 increase the volume of \`channel\` by \`step\`"
  echo "     -d/--down               decrease the volume of \`channel\` by \`step\`"
  echo "     -t/--toggle             toggle the sound of \`channel\` on and off"
  echo "     -b/--bluetooth          switch between the main sound to the bluetooth device"
  echo "     -n/--notify             enable notifications"
  echo ""
  echo "Environment variables:"
  echo "     DEVICE                  the bluetooth device connected (defaults to 'JBL Xtreme')"
  echo "     ON                      the 'on' sink related to the \`device\` (defaults to 'a2dp_sink')"
  echo "     OFF                     the 'on' sink related to the \`device\` (defaults to 'off')"
  echo "     ICONS                   the path the the icons (defaults to '/usr/share/icons/a2n-s-icons')"
  echo "     DUNST_ID                the id of the sound notification, to replace them properly (defaults to 2)"
  exit 0
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help )      help ;;
      -u | --up )        ACTION="up"; shift 1 ;;
      -d | --down )      ACTION="down"; shift 1 ;;
      -t | --toggle )    ACTION="toggle"; shift 1 ;;
      -b | --bluetooth ) ACTION="bluetooth"; shift 1 ;;
      -c | --channel )   CHANNEL="$2"; shift 2 ;;
      -s | --step )      STEP="$2"; shift 2 ;;
      -n | --notify )    NOTIFY="yes"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  # an action is required
  [ -z "$ACTION" ] && usage
  # everything that is not bluetooth requires a channel
  [ ! "$ACTION" = "bluetooth" -a -z "$CHANNEL" ] && usage
  # up and down require a step size
  [ "$ACTION" = "up" -a -z "$STEP" ] && usage
  [ "$ACTION" = "down" -a -z "$STEP" ] && usage
  case "$ACTION" in
    up )        amixer -q sset "$CHANNEL" "$STEP"%+; [[ "$NOTIFY" == "yes" ]] && notify "$CHANNEL";;
    down )      amixer -q sset "$CHANNEL" "$STEP"%-; [[ "$NOTIFY" == "yes" ]] && notify "$CHANNEL";;
    toggle )    amixer -q sset "$CHANNEL" toggle; [[ "$NOTIFY" == "yes" ]] && mute_notify "$CHANNEL" ;;
    bluetooth ) bluetooth_toggle ; [[ "$NOTIFY" == "yes" ]] && bluetooth_notify ;;
    * ) echo "an error occured (got unexpected '$ACTION')"; exit 1 ;;
  esac
}

main "$@"
