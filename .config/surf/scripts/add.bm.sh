#!/usr/bin/env sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                         ____      __                  _       __             __             __    __         __                            __
#        _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ____ _____/ /___/ /        / /_  ____ ___           _____/ /_
#       / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __ `/ __  / __  /        / __ \/ __ `__ \         / ___/ __ \
#      (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / /_/ / /_/ /   _    / /_/ / / / / / /   _    (__  ) / / /
#     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \__,_/\__,_/\__,_/   (_)  /_.___/_/ /_/ /_/   (_)  /____/_/ /_/
#                                                    /_/
#
# Description:  saves a url by adding it to the list of all bookmarks for surf.
# Dependencies: xprop, a bookmark file at ~/.config/surf/bookmarks
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

bookmarks="$HOME/.config/surf/bookmarks"
uri=$(echo $(xprop -id $1 $2) | cut -d \" -f2 | sed 's/.*https*:\/\/\(www\.\)\?//')
sed -i "1s@^@-- | -- | -- | $uri\n@" $bookmarks
