#!/usr/bin/env bash
#           ___
#      __ _|_  )_ _ ___ ___   personal page: https://a2n-s.github.io/
#     / _` |/ /| ' \___(_-<   github   page: https://github.com/a2n-s
#     \__,_/___|_||_|  /__/   my   dotfiles: https://github.com/a2n-s/dotfiles
#        _     __  _        __  _          _   _                     _
#       | |   / / | |__    / / | |__  __ _| |_| |_ ___ _ _ _  _   __| |_
#      _| |  / /  | '_ \  / /  | '_ \/ _` |  _|  _/ -_) '_| || |_(_-< ' \
#     (_)_| /_/   |_.__/ /_/   |_.__/\__,_|\__|\__\___|_|  \_, (_)__/_||_|
#                                                          |__/
# Description:  a script to check the state of the battery and throw appropriate notifications.
#   run `sudo systemctl enable cronie` to activate the `cron` daemon if not already done, then
#   add `* * * * * DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=<address> $HOME/.local/bin/battery.sh`
#   to the `cron` table with `crontab -e` and restart the `cron` daemon with
#   `sudo systemctl restart cronie`. The address can be found with `echo $DBUS_SESSION_BUS_ADDRESS`.
# Dependencies: dunst.
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o hcp --long help,check,print \
              -n 'sound.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# allow the user to change the environment variables.
[ -z "$BATTERY" ] && BATTERY="BAT0"
[ -z "$LOW" ] && LOW=15
[ -z "$HIGH" ] && HIGH=85
[ -z "$ICONS" ] && ICONS="/usr/share/icons/a2n-s-icons"
echo "BATTERY: $BATTERY"
echo "LOW: $LOW"
echo "HIGH: $HIGH"

# the location of the battery information files
SUPPLY="/sys/class/power_supply"


_get_battery_status() {
    # Compute the status of the battery.
    #
    # Args:
    #   $1 (str): the name of the battery.
    #
    # Returns:
    #   status (str): the status of the battery BAT0.
    status="$(cat "$SUPPLY/$1/status")"
    echo "$status"
}


_get_battery_level() {
    # Compute the level of the battery.
    #
    # Args:
    #   $1 (str): the name of the battery.
    #
    # Returns:
    #   stat (int): the level of the battery BAT0.
    level="$(cat "$SUPPLY/$1/capacity")"
    echo "$level"
}


_check_battery_state() {
    # Check the state of the battery.
    #
    # The battery is considered:
    #   - "low" when discharging and below the "$LOW" bound.
    #   - "high" when charging and above the "$HIGH" bound.
    #
    # Args:
    #   $1 (str): the status of the battery.
    #   $2 (str): the level of the battery.
    #
    # Returns:
    #   state (str): the general state of the battery, i.e. either "low",
    #       "high" or empty, which means the state should be considered ok.
    status="$1"
    level="$2"
    if [ "$status" = "Discharging" ] && [ "$level" -le "$LOW" ]; then
        state="low"
    elif [ "$level" -ge "$HIGH" ]; then
        if [ "$status" = "Not Charging" ] || [ "$status" = "Charging" ]; then
            state="high"
        fi
    fi
    echo "$state"
}

print_battery () {
    # Print the state of the battery in a notification.
    #
    # Args:
    #   $1: the status of the battery.
    #   $2: the level of the battery.
    status="$1"
    level="$2"
    if [ "$level" -lt "25" ]; then
        icon="critical"
    elif [ "$level" -lt "50" ]; then
        icon="low"
    elif [ "$level" -lt "75" ]; then
        icon="normal"
    else
        icon="full"
    fi
    dunstify --urgency low "battery.sh" "$BATTERY is $status at $level" --icon="$ICONS/battery-$icon.png" --timeout 5000
}

check_battery () {
    # Check the battery and throw notifications if needed.
    # get the status and the level of the battery.
    status=$(_get_battery_status "$BATTERY")
    level=$(_get_battery_level "$BATTERY")
    echo "status: $status"
    echo "level: $level"

    state="$(_check_battery_state "$status" "$level")"

    # throw a notification only if required.
    [ -n "$state" ] && {
        if [ "$state" = "low" ]; then
            icon="$ICONS/battery-critical.png"
        elif [ "$state" = "high" ]; then
            icon="$ICONS/battery-full.png"
        fi
        dunstify --urgency critical "battery.sh" "$BATTERY is $state" --icon="$icon";
        print_battery "$status" "$level"
    }
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help )   help ;;
      -c | --check )  ACTION="check"; shift 1 ;;
      -p | --print )  ACTION="print"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  # an action is required
  [ -z "$ACTION" ] && usage
  case "$ACTION" in
    check ) check_battery ;;
    print ) print_battery "$(_get_battery_status "$BATTERY")" "$(_get_battery_level "$BATTERY")" ;;
    * ) echo "an error occured (got unexpected '$ACTION')"; exit 1 ;;
  esac
}

main "$@"
