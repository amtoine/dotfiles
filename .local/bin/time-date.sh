#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#        _     __  _        __  _   _                  _      _            _
#       | |   / / | |__    / / | |_(_)_ __  ___ ___ __| |__ _| |_ ___   __| |_
#      _| |  / /  | '_ \  / /  |  _| | '  \/ -_)___/ _` / _` |  _/ -_)_(_-< ' \
#     (_)_| /_/   |_.__/ /_/    \__|_|_|_|_\___|   \__,_\__,_|\__\___(_)__/_||_|
#
# Description:  show the date and the time in a notification.
# Dependencies: date.
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"

notify-send -t 3500 "$(date '+%a %b %e%n%r')" --icon="$ICONS/calendar.png"
