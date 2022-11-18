#!/usr/bin/env sh

bookmarks="$HOME/.config/surf/bookmarks"
uri=$(echo $(xprop -id $1 $2) | cut -d \" -f2 | sed 's/.*https*:\/\/\(www\.\)\?//')
sed -i "1s@^@-- | -- | -- | $uri\n@" $bookmarks
