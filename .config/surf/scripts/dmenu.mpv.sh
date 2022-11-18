#!/usr/bin/env sh

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
