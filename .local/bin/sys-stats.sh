#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#        _     __  _        __                    _        _           _
#       | |   / / | |__    / /  ____  _ ______ __| |_ __ _| |_ ___  __| |_
#      _| |  / /  | '_ \  / /  (_-< || (_-<___(_-<  _/ _` |  _(_-<_(_-< ' \
#     (_)_| /_/   |_.__/ /_/   /__/\_, /__/   /__/\__\__,_|\__/__(_)__/_||_|
#                                  |__/
#
# Description:  show some system information.
# Dependencies: sensors, grep, awk, free, top.
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"

dunstify "sys-stats.sh" "polling the system for information..." --icon="$ICONS/gears.png"

memory=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
load=$(top -bn1 | grep load | awk '{printf "%.2f\n", $(NF-2)}')
cpu_temp=$(sensors | grep 'Core .:' | awk -F' ' '{ print $3 }')

dunstify "Usage" "$memory" --icon="$ICONS/usage-chart.png"
dunstify "Load" "$load" --icon="$ICONS/brain-machine.png"
dunstify "CPU" "$cpu_temp" --icon="$ICONS/temperature.png"
