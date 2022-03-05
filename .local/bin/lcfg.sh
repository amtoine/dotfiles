#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __  _     __           _
#      ___   / / | |__ / _|__ _   __| |_
#     (_-<  / /  | / _|  _/ _` |_(_-< ' \
#     /__/ /_/   |_\__|_| \__, (_)__/_||_|
#                         |___/
#
# Description:  a wrapper around lazygit to use it from anywhere on the dotfiles.
# Dependencies:
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

/usr/bin/lazygit --git-dir="$HOME/.dotfiles" --work-tree="$HOME"
