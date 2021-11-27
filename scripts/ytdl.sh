#! /usr/bin/bash
#                        _       __             __         __      ____              __
#        _______________(_)___  / /______     _/_/  __  __/ /_____/ / /        _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / / / / __/ __  / /        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / /_/ /_/ / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \__, /\__/\__,_/_/   (_)  /____/_/ /_/
#                     /_/                        /____/

# Description: allows one to download a youtube video audio or a whole playlist.
# Dependencies: youtube-dl
# GitHub: https://github.com/a2n-s/dotfiles
# License: https://github.com/a2n-s/dotfiles/LICENSE
# Contributors: Stevan Antoine

youtube-dl \
     --ignore-errors \
     --yes-playlist \
     --continue \
     -f 249 \
     --extract-audio \
     --audio-format mp3 \
     --no-overwrites \
     --download-archive ~/Music/progress.txt \
     --output '~/Music/%(playlist)s - %(playlist_index)s - %(title)s.%(ext)s' \
     --add-metadata \
     --metadata-from-title "%(artist)s - %(title)s" \
     $1
#     --exec 'ffmpeg -y -loglevel repeat+info -i 'file:{}' -c copy -metadata 'album=DL31' 'file:{}.tmp'' \
#     $1
