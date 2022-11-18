#!/usr/bin/env sh

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
