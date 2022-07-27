#!/bin/sh

[[ ! -v ICONS ]] && ICONS="/usr/share/icons/amtoine-icons-git/dark/128x128"

dunstify --urgency normal "Music On Console" "Server stopped" --icon "$ICONS/audio/stop.png"
