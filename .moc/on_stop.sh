#!/bin/sh

[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons-git"

dunstify --urgency normal "Music On Console" "Server stopped" --icon "$ICONS/audio-music.png"
