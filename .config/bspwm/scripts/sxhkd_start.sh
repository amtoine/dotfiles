#!/usr/bin/env bash
#           ___
#      __ _|_  )_ _ ___ ___   personal page: https://a2n-s.github.io/
#     / _` |/ /| ' \___(_-<   github   page: https://github.com/a2n-s
#     \__,_/___|_||_|  /__/   my   dotfiles: https://github.com/a2n-s/dotfiles
#               __  _        __         __         _    _      _      _            _        _
#        __    / / | |__    / /  ___   / /  ____ _| |_ | |____| |  __| |_ __ _ _ _| |_   __| |_
#      _/ _|  / /  | '_ \  / /  (_-<  / /  (_-< \ / ' \| / / _` | (_-<  _/ _` | '_|  _|_(_-< ' \
#     (_)__| /_/   |_.__/ /_/   /__/ /_/   /__/_\_\_||_|_\_\__,_|_/__/\__\__,_|_|  \__(_)__/_||_|
#                                                              |___|
#
# Description:  my autostart script of sxhkd for bspwm.
# Dependencies: sxhkd
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

# the configuration files.
SXHKD_COMMON="$HOME/.config/sxhkd/sxhkdrc"
SXHKD_BSPWM="$HOME/.config/bspwm/sxhkd/sxhkdrc"

# the environment variables used by sxhkd.
export DMFONT="mononoki Nerd Font-20"
export SCRIPTS="/usr/local/bin"
export TERM="st"
export TERM_FLAGS="-e"
export TERM_SHELL="fish"

# restart sxhkd.
killall sxhkd
sxhkd -c "$SXHKD_COMMON" "$SXHKD_BSPWM" &
