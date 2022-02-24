#!/bin/sh
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __  _  __                    _
#      ___   / / | |/ _|_ _ _  _ _ _    __| |_
#     (_-<  / /  | |  _| '_| || | ' \ _(_-< ' \
#     /__/ /_/   |_|_| |_|  \_,_|_||_(_)__/_||_|
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
