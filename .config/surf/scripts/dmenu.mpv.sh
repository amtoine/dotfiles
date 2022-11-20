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

if [[ "$1" == *"playlist"* ]]; then
  quality=$(echo -e "480\n360\n240\n144\n720\n1080" | dmenu -fn "$DMFONT" -l 10 -p "Video quality (press escape at any time to abort)"); [[ "$quality" == "" ]] && exit 1
  shuffle=$(echo -e "No\nYes\n" | dmenu -fn "$DMFONT" -p "Shuffle?"); [[ "$shuffle" == "" ]] && exit 1
  loop=$(echo -e "inf\nno\nforce" | dmenu -fn "$DMFONT" -p "Loop? (option | number of loops)"); [[ "$loop" == "" ]] && exit 1
  index=$(echo -e "auto" | dmenu -fn "$DMFONT" -p "Start video (auto | index)"); [[ "$index" == "" ]] && exit 1
  video=$(echo -e "Yes\nNo\n" | dmenu -fn "$DMFONT" -p "Video?"); [[ "$video" == "" ]] && exit 1
  if [[ $video == "Yes" ]]; then
    CMD="mpv --really-quiet"
  else
    CMD="kitty mpv --no-video"
  fi
  if [[ $shuffle == "Yes" ]]; then
    $CMD --playlist-start="$index" --loop-playlist="$loop" --ytdl-format="bestvideo[ext=mp4][height<=?$quality]+bestaudio[ext=m4a]" "$1" --shuffle
  else
    $CMD --playlist-start="$index" --loop-playlist="$loop" --ytdl-format="bestvideo[ext=mp4][height<=?$quality]+bestaudio[ext=m4a]" "$1"
  fi
else
  quality=$(echo -e "480\n360\n240\n144\n720\n1080" | dmenu -fn "$DMFONT" -l 10 -p "Video quality (press escape to abort)"); [[ "$quality" == "" ]] && exit 1
  video=$(echo -e "Yes\nNo\n" | dmenu -fn "$DMFONT" -p "Video?"); [[ "$video" == "" ]] && exit 1
  if [[ $video == "Yes" ]]; then
    CMD="mpv --really-quiet"
  else
    CMD="kitty mpv --no-video"
  fi
  $CMD --ytdl-format="bestvideo[ext=mp4][height<=?$quality]+bestaudio[ext=m4a]" "$1"
fi
