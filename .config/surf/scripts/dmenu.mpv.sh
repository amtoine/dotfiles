#!/usr/bin/env sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                         ____      __                  _       __             __       __                                                                       __
#        _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ____/ /___ ___  ___  ____  __  __         ____ ___  ____ _   __         _____/ /_
#       / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __  / __ `__ \/ _ \/ __ \/ / / /        / __ `__ \/ __ \ | / /        / ___/ __ \
#      (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / / / / / /  __/ / / / /_/ /   _    / / / / / / /_/ / |/ /   _    (__  ) / / /
#     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \__,_/_/ /_/ /_/\___/_/ /_/\__,_/   (_)  /_/ /_/ /_/ .___/|___/   (_)  /____/_/ /_/
#                                                    /_/                                                                           /_/
#
# Description:  Meant to be used from surf: asks the user to choose a video quality and then opens
#               mpv instance with the video or the playlist. When a playlist is selected, the dmenu asks the user
#               whether to shuffle the playlist or not, about the loop option on the playlist and the start index.
#               One can simply abort the process at any time by pressing escape.
# Dependencies: mpv, youtube-dl, dmenu
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

quality=$(echo -e "144\n240\n360\n480\n720\n1080" | dmenu -l 10 -p "Video quality (press escape at any time to abort)"); [[ "$quality" == "" ]] && exit 1
if [[ "$1" == *"playlist"* ]]; then
  shuffle=$(echo -e "Yes\nNo\n" | dmenu -p "Shuffle?"); [[ "$shuffle" == "" ]] && exit 1
  loop=$(echo -e "inf\nno\nforce" | dmenu -p "Loop? (option | number of loops)"); [[ "$loop" == "" ]] && exit 1
  index=$(echo -e "auto" | dmenu -p "Start video (auto | index)"); [[ "$index" == "" ]] && exit 1
  if [[ $shuffle == "Yes" ]]; then
    mpv --playlist-start="$index" --loop-playlist="$loop" --ytdl-format="bestvideo[ext=mp4][height<=?$quality]+bestaudio[ext=m4a]" --really-quiet "$1" --shuffle
  else
    mpv --playlist-start="$index" --loop-playlist="$loop" --ytdl-format="bestvideo[ext=mp4][height<=?$quality]+bestaudio[ext=m4a]" --really-quiet "$1"
  fi
else
  mpv --ytdl-format="bestvideo[ext=mp4][height<=?$quality]+bestaudio[ext=m4a]" --really-quiet "$1"
fi
