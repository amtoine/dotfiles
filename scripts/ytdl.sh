#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __       _   _    _         _
#      ___   / /  _  _| |_| |__| |_ _  __| |_
#     (_-<  / /  | || |  _| / _` | '_|(_-< ' \
#     /__/ /_/    \_, |\__|_\__,_|_|(_)__/_||_|
#                 |__/
#
# Description:  allows one to download a youtube video audio or a whole playlist.
#               WORK IN PROGRESS
# Dependencies: youtube-dl
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

youtube-dl \
     --ignore-errors \
     --yes-playlist \
     --continue \
     -f 249 \
     --extract-audio \
     --audio-format mp3 \
     --no-overwrites \
     --download-archive "$2" \
     --output '~/music/%(playlist)s/%(playlist)s - %(playlist_index)s - %(title)s.%(ext)s' \
     --add-metadata \
     --metadata-from-title "%(artist)s - %(title)s" \
     $1
#     --exec 'ffmpeg -y -loglevel repeat+info -i 'file:{}' -c copy -metadata 'album=DL31' 'file:{}.tmp'' \
#     $1
