#!/usr/bin/env sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                         ____      __                  _       __             __       __                                              __                                       __
#        _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ____/ /___ ___  ___  ____  __  __         ________  / /_____  _________  ____           _____/ /_
#       / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __  / __ `__ \/ _ \/ __ \/ / / /        / ___/ _ \/ __/ __ \/ ___/ __ \/ __ \         / ___/ __ \
#      (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / / / / / /  __/ / / / /_/ /   _    (__  )  __/ /_/ /_/ / /  / /_/ / /_/ /   _    (__  ) / / /
#     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \__,_/_/ /_/ /_/\___/_/ /_/\__,_/   (_)  /____/\___/\__/ .___/_/   \____/ .___/   (_)  /____/_/ /_/
#                                                     /_/                                                                               /_/              /_/
#
# Description:  Opens a dmenu menu in surf with all the bookmarks and the current url.
# Dependencies: xprop, dmenu, a bookmark file at ~/.config/surf/bookmarks
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

if [[ "$4" = '_SURF_FIND' ]]; then
  prop=$(echo "" | dmenu -p "$5" -w "$2")
else
  bookmarks="$HOME/.config/surf/bookmarks"
  uri=$(xprop -id $2 $3 | sed "s/^$3(UTF8_STRING) = //; s/^\"\(.*\)\"$/\1/")
  prop=$(printf '%b' "$(echo "$uri"; cat $bookmarks | grep -v '^$')" | dmenu -i -F -l 10 -p "$5" -w "$2")
fi
prop=$(echo "$prop" | sed "s/.*|\s\+//g")
xprop -id "$2" -f "$4" 8u -set "$4" "$prop"
