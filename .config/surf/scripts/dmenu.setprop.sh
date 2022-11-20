#!/usr/bin/env sh
#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

DMFONT="mononoki Nerd Font-15"

if [[ "$4" = '_SURF_FIND' ]]; then
  prop=$(echo "" | dmenu -p "$5" -w "$2")
else
  bookmarks="$HOME/.config/surf/bookmarks"
  uri=$(xprop -id $2 $3 | sed "s/^$3(UTF8_STRING) = //; s/^\"\(.*\)\"$/\1/")
  prop=$(printf '%b' "$(echo "$uri"; cat $bookmarks | grep -v '^$')" | dmenu -fn "$DMFONT" -i -F -l 10 -bw 5 -p "$5" -w "$2")
fi
prop=$(echo "$prop" | sed "s/.*|\s\+//g")
xprop -id "$2" -f "$4" 8u -set "$4" "$prop"
