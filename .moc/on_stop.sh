#!/bin/sh

[[ ! -v ICONS ]] && ICONS="/usr/share/icons/amtoine-icons-git/stickers/100x100"

dunstify --urgency normal "Music On Console" "Server stopped" --icon "$ICONS/audio/stop.png"
