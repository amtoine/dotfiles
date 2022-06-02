#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#        _     __  _        __       _      _ _      _
#       | |   / / | |__    / /  _  _| |_ __| | |  __| |_
#      _| |  / /  | '_ \  / /  | || |  _/ _` | |_(_-< ' \
#     (_)_| /_/   |_.__/ /_/    \_, |\__\__,_|_(_)__/_||_|
#                               |__/
#
# Description:  allows one to download a youtube video audio or a whole playlist.
# Dependencies: youtube-dl
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o hu:a: --long help,url:,archive: -n 'ytdl.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# allow the user to change the environment variables.
[[ ! -v MUSIC_DIR ]] && MUSIC_DIR="$HOME/music"

usage () {
     #
     # the usage function.
     #
     echo "Usage: ytdl.sh [-h] -u URL -a ARCHIVE"
     echo "Type -h or --help for the full help."
     exit 0
}

help () {
     #
     # the help function.
     #
     echo "ytdl.sh:"
     echo "     a script to download music from youtube."
     echo ""
     echo "Usage:"
     echo "     ytdl.sh [-h] -u URL -a ARCHIVE"
     echo ""
     echo "Switches:"
     echo "     -h/--help             shows this help."
     echo "     -u/--url              the url of the video or the playlist to download the sound from."
     echo "     -a/--archive          the name of the archive, namely \`<name_of_playlist>.pg\`, under the \`MUSIC_DIR\` directory."
     echo ""
     echo "Environment variables:"
     echo "     MUSIC_DIR             the location where to store the musics and the archive (defaults to '\$HOME/music')."
     exit 0
}

main () {
     ACTION=""
     while [[ $# -gt 0 ]]; do
     case "$1" in
          -h | --help )     help ;;
          -u | --url )      ACTION="download"; URL="$2"; shift 2 ;;
          -a | --archive )  ACTION="download"; ARCHIVE="$2"; shift 2 ;;
          -- ) shift; break ;;
          * ) break ;;
     esac
     done

     # an action is required
     [ -z "$ACTION" ] && usage
     [ -z "$URL" ] && usage
     [ -z "$ARCHIVE" ] && usage

     youtube-dl \
          --ignore-errors \
          --yes-playlist \
          --continue \
          -f 249 \
          --extract-audio \
          --audio-format mp3 \
          --no-overwrites \
          --download-archive "$MUSIC_DIR/$ARCHIVE" \
          --output "$MUSIC_DIR/%(playlist)s/%(playlist)s - %(playlist_index)s - %(title)s.%(ext)s" \
          --add-metadata \
          --metadata-from-title "%(artist)s - %(title)s" \
          "$URL"
     #     --exec 'ffmpeg -y -loglevel repeat+info -i 'file:{}' -c copy -metadata 'album=DL31' 'file:{}.tmp'' \
     #     $1
}

main "$@"
