#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#                 __           __         __     _                           _   _                       _
#          __    / /  __ _    / /  ___   / /  __| |_  __ _ _ _  __ _ ___ ___| |_| |_  ___ _ __  ___   __| |_
#      _  / _|  / /  / _` |  / /  (_-<  / /  / _| ' \/ _` | ' \/ _` / -_)___|  _| ' \/ -_) '  \/ -_)_(_-< ' \
#     (_) \__| /_/   \__, | /_/   /__/ /_/   \__|_||_\__,_|_||_\__, \___|    \__|_||_\___|_|_|_\___(_)__/_||_|
#                       |_|                                    |___/
#
# Description:  change the theme of qtile with dmenu
# Dependencies: fzf
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

################################################################################################
## Some color definitions ######################################################################
################################################################################################
# Reset
Off=$(printf '\033[0m')        # Text Reset
# Regular Colors
Blk=$(printf '\033[0;30m')     # Black
Red=$(printf '\033[0;31m')     # Red
Grn=$(printf '\033[0;32m')     # Green
Ylw=$(printf '\033[0;33m')     # Yellow
Blu=$(printf '\033[0;34m')     # Blue
Pur=$(printf '\033[0;35m')     # Purple
Cyn=$(printf '\033[0;36m')     # Cyan
Wht=$(printf '\033[0;37m')     # White
# High Intensity
IRed=$(printf '\033[0;91m')    # Red
IGrn=$(printf '\033[0;92m')    # Green
IYlw=$(printf '\033[0;93m')    # Yellow
IBlu=$(printf '\033[0;94m')    # Blue
IPur=$(printf '\033[0;95m')    # Purple
IWht=$(printf '\033[0;97m')    # White
# Bold High Intensity
################################################################################################
## 'Global constants' definitions ##############################################################
################################################################################################
# Specific color use. #
#######################
Err=$IRed  # errors
Wrn=$IYlw  # warnings
Cod=$IBlu  # code
Hed=$IPur  # head
Src=$Pur   # source
Dst=$Grn   # destination
Pmt=$Cyn   # prompt
Tip=$IGrn  # tip

repo="eendroroy/alacritty-theme"
cache="$HOME/.cache/alacritty/themes"

export FZF_DEFAULT_OPTS="
--height=100%
--layout=reverse
--prompt='Change alacritty theme: '"

  # download the themes list from remote.
if [[ ! -d "$cache" ]]; then
  echo "Downloading themes from ${Src}$repo${Off} to ${Dst}$cache${Off}.";
  git clone -q "https://github.com/$repo.git" "$cache";
fi

if [ ! -z "$1" ];
then
  if ls "$cache/themes" | sed 's/\.yaml$//g' | grep -w "$1" > /dev/null
  then
    theme="$1.yaml"
  else
    echo "No theme named: $1"
    exit 1
  fi
else
  # use fzf to let the user choose the theme.
  theme=$(alacritty-colorscheme -C "$cache/themes" list | fzf)
  if [ "$theme" == "" ]; then
    echo "${Wrn}No theme selected. Aborting.${Off}";
    exit 1
  fi
fi

alacritty-colorscheme -C "$cache/themes" apply "$theme"
