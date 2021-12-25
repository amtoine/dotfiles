#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __   __              __   __                  __
#        _______________(_)___  / /______     _/_/  / /_____  ____ _/ /__/ /_           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __/ __ \/ __ `/ //_/ __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ /_/ / /_/ / ,< / /_/ /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \__/\____/\__, /_/|_/_.___/   (_)  /____/_/ /_/
#                     /_/                                  /____/

# Description:  toggles the keyboard layout between qwerty and azerty.
# Dependencies: setxkbmap 
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

if [[ $(setxkbmap -query | grep layout | sed "s/layout:\s\+\(.*\)/\1/") = fr ]]; then
	setxkbmap -layout us;
elif [[ $(setxkbmap -query | grep layout | sed "s/layout:\s\+\(.*\)/\1/") = us ]]; then
	setxkbmap -layout fr;
fi
