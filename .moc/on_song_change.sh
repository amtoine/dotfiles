#!/bin/sh
#
# Args:
#   $1: the artist.
#   $2: the title.
#   $3: the duration.

[[ ! -v ICONS ]] && ICONS="/usr/share/icons/goat-icons-git/stickers/100x100"

dunstify --urgency normal "$1" "$2\n$3" --icon "$ICONS/audio/music.png"
