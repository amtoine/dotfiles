#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __   ______                               __
#        _______________(_)___  / /______     _/_/  / / __/______  ______           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / / /_/ ___/ / / / __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / / __/ /  / /_/ / / / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /_/_/ /_/   \__,_/_/ /_/   (_)  /____/_/ /_/
#                     /_/
#
# Description:  wrapper around lf to support advanced file preview with ueberzug.
#               creates cache files to make previews faster once computed one time.
# Dependencies: ueberzug
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine
#               gokcehan -> https://github.com/gokcehan/lf/wiki/Previews 

set -e

if [ -n "$DISPLAY" ]; then
  export FIFO_UEBERZUG="${TMPDIR:-/tmp}/lf-ueberzug-$$"

  cleanup() {
    exec 3>&-
    rm "$FIFO_UEBERZUG"
  }

  mkfifo "$FIFO_UEBERZUG"
  ueberzug layer -s <"$FIFO_UEBERZUG" &
  exec 3>"$FIFO_UEBERZUG"
  trap cleanup EXIT

  if ! [ -d "$HOME/.cache/lf" ]; then
    mkdir -p "$HOME/.cache/lf"
  fi

  lf "$@" 3>&-
else
  exec lf "$@"
fi
