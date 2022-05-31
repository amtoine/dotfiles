#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#        _     __  _        __                  _   _                         _        _
#       | |   / / | |__    / / __ __ _____ __ _| |_| |_  ___ _ _ ___ __ _ ___| |_   __| |_
#      _| |  / /  | '_ \  / /  \ V  V / -_) _` |  _| ' \/ -_) '_|___/ _` / -_)  _|_(_-< ' \
#     (_)_| /_/   |_.__/ /_/    \_/\_/\___\__,_|\__|_||_\___|_|     \__, \___|\__(_)__/_||_|
#                                                                   |___/
# Description:  show the weather of some places in the world.
# Dependencies: curl
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"
[[ ! -v PLACES ]] && PLACES="Paris,Seoul,Nantes"

notify-send -t 4500 "$(curl -s "wttr.in/{$PLACES}?format=3")" --icon="$ICONS/weather-cloud-and-sun.png"
