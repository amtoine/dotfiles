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

# allow the user to change the environment variables.
[ -z "$BATTERY" ] && BATTERY="BAT0"
[ -z "$LOW" ] && LOW=15
[ -z "$HIGH" ] && HIGH=85
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


# get the status and the level of the battery.
status=$(_get_battery_status "$BATTERY")
level=$(_get_battery_level "$BATTERY")
echo "status: $status"
echo "level: $level"

state="$(_check_battery_state "$status" "$level")"

# throw a notification only if required.
[ -n "$state" ] && {
    dunstify --urgency critical "battery.sh" "Battery is $state";
    dunstify --urgency low "battery.sh" "Battery is $status at $level" --timeout 5000
}
