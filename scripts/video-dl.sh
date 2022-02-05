#!/bin/bash


if [[ -v AUDIO ]]; then
  youtube-dl --format "bestaudio[ext=m4a]" --extract-audio "$1"
else
  [[ ! -v QUALITY ]] && QUALITY="480"
  echo "${QUALITY}p"
  youtube-dl --format "bestvideo[ext=mp4][height<=?$QUALITY]+bestaudio[ext=m4a]" "$1"
fi
exit 0
