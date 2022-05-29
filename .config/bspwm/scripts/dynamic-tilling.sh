#!/bin/bash
#           ___
#      __ _|_  )_ _ ___ ___   personal page: https://a2n-s.github.io/
#     / _` |/ /| ' \___(_-<   github   page: https://github.com/a2n-s
#     \__,_/___|_||_|  /__/   my   dotfiles: https://github.com/a2n-s/dotfiles
#               __  _        __         __     _                      _        _   _ _ _ _                _
#        __    / / | |__    / /  ___   / /  __| |_  _ _ _  __ _ _ __ (_)__ ___| |_(_) | (_)_ _  __ _   __| |_
#      _/ _|  / /  | '_ \  / /  (_-<  / /  / _` | || | ' \/ _` | '  \| / _|___|  _| | | | | ' \/ _` |_(_-< ' \
#     (_)__| /_/   |_.__/ /_/   /__/ /_/   \__,_|\_, |_||_\__,_|_|_|_|_\__|    \__|_|_|_|_|_||_\__, (_)__/_||_|
#                                                |__/                                          |___/
#
# switches from one layout to another and gives a little message box.


if [ "$1" == "first_child" ]
then
  bspc config automatic_scheme first_child
  dunstify "Switched to first_child mode!"
  exit 0
elif [ "$1" == "longest_side" ]
then
  bspc config automatic_scheme longest_side
  dunstify "Switched to longest_side mode!"
  exit 0
elif [ "$1" == "spiral" ]
then
  bspc config automatic_scheme spiral
  dunstify "Switched to spiral mode!"
  exit 0
else
  dunstify "Invalid mode!"
  exit 1
fi
