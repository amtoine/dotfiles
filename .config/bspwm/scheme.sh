#!/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                               _____             __   __                                       __             __                                      __
#             _________  ____  / __(_)___ _     _/_/  / /_  _________ _      ______ ___       _/_/  __________/ /_  ___  ____ ___  ___           _____/ /_
#            / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / __ \/ ___/ __ \ | /| / / __ `__ \    _/_/   / ___/ ___/ __ \/ _ \/ __ `__ \/ _ \         / ___/ __ \
#      _    / /__/ /_/ / / / / __/ / /_/ /  _/_/    / /_/ (__  ) /_/ / |/ |/ / / / / / /  _/_/    (__  ) /__/ / / /  __/ / / / / /  __/   _    (__  ) / / /
#     (_)   \___/\____/_/ /_/_/ /_/\__, /  /_/     /_.___/____/ .___/|__/|__/_/ /_/ /_/  /_/     /____/\___/_/ /_/\___/_/ /_/ /_/\___/   (_)  /____/_/ /_/
#                                 /____/                     /_/
#
# switches from one layout to another and gives a little message box.


if [ "$1" == "first_child" ]
then
  bspc config automatic_scheme first_child
  zenity --info --width=200 --height=100 --text "Switched to first_child mode!"
  exit 0
elif [ "$1" == "longest_side" ]
then
  bspc config automatic_scheme longest_side
  zenity --info --width=200 --height=100 --text "Switched to longest_side mode!"
  exit 0
elif [ "$1" == "spiral" ]
then
  bspc config automatic_scheme spiral
  zenity --info --width=200 --height=100 --text "Switched to spiral mode!"
  exit 0
else
  zenity --info --width=200 --height=100 --text "Invalid mode!"
  exit 1
fi

