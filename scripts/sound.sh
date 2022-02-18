#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __                              __              __  
#        _______________(_)___  / /______     _/_/  _________  __  ______  ____/ /        _____/ /_ 
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / ___/ __ \/ / / / __ \/ __  /        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    (__  ) /_/ / /_/ / / / / /_/ /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /____/\____/\__,_/_/ /_/\__,_/   (_)  /____/_/ /_/ 
#                     /_/                                                                           
#
# Description:  manages sound and bluetooth sinks.
#               one can use multiple flags, only the last one will be used.
# Dependencies: amixer, ~/scripts/bluetooth.toggle.sh
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

OPTIONS=$(getopt -o udtmbs:c:n --long up,down,toggle,bluetooth,step:,channel:,notify \
              -n 'sound.sh' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$OPTIONS"

CHANNEL="Master"
STEP="5"

[[ ! -v DEVICE ]] && DEVICE="JBL Xtreme"
[[ ! -v ON ]] && ON="a2dp_sink"
[[ ! -v OFF ]] && OFF="off"
NUM=$(pacmd list-cards | grep -B5 "$DEVICE" | head -1 | sed 's/\s\+index: //')

bluetooth_on () {
    echo "device ($1) on"
    pacmd set-card-profile "$1" $ON
}

bluetooth_off () {
    echo "device ($1) off"
    pacmd set-card-profile "$1" $OFF
}

bluetooth_toggle () {
    if pacmd list-cards | grep -B5 "$DEVICE" | grep 'active profile'
    then
        bluetooth_off "$1"
    else
        bluetooth_on "$1"
    fi
}

notify () {
  _volume=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }' | sed 's/%//')
  dunstify volume -h "int:value:$_volume"
}
mute_notify () {
  if amixer sget "$1" | grep "\[on\]" > /dev/null; then
    dunstify "$1" "Device unmuted" 
  else
    dunstify "$1" "Device muted" 
  fi
}
bluetooth_notify () {
  echo "LOL"
  if pacmd list-cards | grep -B5 "JBL Xtreme" | grep 'active profile'
  then
    dunstify "Bluetooth" "active" 
  else
    dunstify "Bluetooth" "disabled" 
  fi
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
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
  case "$ACTION" in
    up )        amixer -q sset "$CHANNEL" "$STEP"%+; [[ "$NOTIFY" == "yes" ]] && notify ;;
    down )      amixer -q sset "$CHANNEL" "$STEP"%-; [[ "$NOTIFY" == "yes" ]] && notify ;;
    toggle )    amixer -q sset Master toggle; [[ "$NOTIFY" == "yes" ]] && mute_notify "$CHANNEL" ;;
    bluetooth ) bluetooth_toggle "$NUM" ; [[ "$NOTIFY" == "yes" ]] && bluetooth_notify ;;
    * ) echo "an error occured (got unexpected '$ACTION')"; exit 1 ;;
  esac
}

main "$@"
