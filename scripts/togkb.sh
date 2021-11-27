#! /usr/bin/bash
#                        _       __             __   __              __   __                  __
#        _______________(_)___  / /______     _/_/  / /_____  ____ _/ /__/ /_           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __/ __ \/ __ `/ //_/ __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ /_/ / /_/ / ,< / /_/ /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \__/\____/\__, /_/|_/_.___/   (_)  /____/_/ /_/
#                     /_/                                  /____/

# Description: toggles the keyboard layout between qwerty and azerty.
# Dependencies: setxkbmap 
# GitHub: https://github.com/a2n-s/dotfiles 
# License: https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

echo "togkb"
if [[ $(setxkbmap -query | grep layout | sed "s/layout:\s\+\(.*\)/\1/") = fr ]]; then
	setxkbmap -layout us;
elif [[ $(setxkbmap -query | grep layout | sed "s/layout:\s\+\(.*\)/\1/") = us ]]; then
	setxkbmap -layout fr;
fi
