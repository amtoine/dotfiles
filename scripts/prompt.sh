#! /usr/bin/bash
#                        _       __             __                                    __
#        _______________(_)___  / /______     _/_/  ____  _________  ____ ___  ____  / /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __ \/ ___/ __ \/ __ `__ \/ __ \/ __/
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / /  / /_/ / / / / / / /_/ / /_
#     /____/\___/_/  /_/ .___/\__/____/  /_/     / .___/_/   \____/_/ /_/ /_/ .___/\__/
#                     /_/                       /_/                        /_/
#
# Description: a dmenu binary prompt inspired from https://www.youtube.com/watch?v=R9m723tAurA 
#              Gives a dmenu prompt labeled with $1 and ask to perform command $2.

#              For example:
#              ~/scripts/prompt "Do you really want to shutdown your machine?" "shutdown -h now"
#              will ask you before shutting down.
# Dependencies: dmenu
# GitHub: https://github.com/a2n-s/dotfiles 
# License: https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

[[ $(/usr/bin/echo -e "No\nYes" | /usr/bin/dmenu -i -p "$1") == "Yes" ]] && $2
