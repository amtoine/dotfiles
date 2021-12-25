#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __         __      ____              __
#        _______________(_)___  / /______     _/_/  __  __/ /_____/ / /        _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / / / / __/ __  / /        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / /_/ /_/ / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \__, /\__/\__,_/_/   (_)  /____/_/ /_/
#                     /_/                        /____/

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
     --download-archive ~/Music/progress.txt \
     --output '~/Music/%(playlist)s - %(playlist_index)s - %(title)s.%(ext)s' \
     --add-metadata \
     --metadata-from-title "%(artist)s - %(title)s" \
     $1
#     --exec 'ffmpeg -y -loglevel repeat+info -i 'file:{}' -c copy -metadata 'album=DL31' 'file:{}.tmp'' \
#     $1
