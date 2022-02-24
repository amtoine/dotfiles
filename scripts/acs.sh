#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                  _
#      ___   / /  __ _ __ ___  __| |_
#     (_-<  / /  / _` / _(_-<_(_-< ' \
#     /__/ /_/   \__,_\__/__(_)__/_||_|
#
# Description:  the Alacritty Change Scheme script: change the theme of alacritty with fzf
# Dependencies: fzf
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

################################################################################################
## Some color definitions ######################################################################
################################################################################################
Off=$(printf '\033[0m')        # Text Reset
Grn=$(printf '\033[0;32m')     # Green
Pur=$(printf '\033[0;35m')     # Purple
IYlw=$(printf '\033[0;93m')    # Yellow

################################################################################################
## 'Global constants' definitions ##############################################################
################################################################################################
# Specific color use. #
#######################
Wrn=$IYlw  # warnings
Src=$Pur   # source
Dst=$Grn   # destination

# the environment variables
[[ ! -v REPO ]] && REPO="eendroroy/alacritty-theme"
[[ ! -v CACHE ]] && CACHE="$HOME/.cache/alacritty/themes"

export FZF_DEFAULT_OPTS="
--height=100%
--layout=reverse
--prompt='Change alacritty theme: '"

# parse the arguments.
OPTIONS=$(getopt -o h --long help -n 'acs.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

help () {
  #
  # the help function.
  #
  echo "acs.sh:"
  echo "     This script allows the user to easily change"
  echo "     alacritty's theme."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     acs.sh [-h] [THEME]"
  echo ""
  echo "Switches:"
  echo "     -h/--help   shows this help."
  echo ""
  echo "Environment variables:"
  echo "     REPO        the path to the remote where the themes are stored (defaults to 'eendroroy/alacritty-theme')"
  echo "     CACHE       the path where the themes are stored locally       (defaults to '\$HOME/.cache/alacritty/themes')"
  exit 0
}

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
    # download the themes list from remote.
  if [[ ! -d "$CACHE" ]]; then
    echo "Downloading themes from ${Src}$REPO${Off} to ${Dst}$CACHE${Off}.";
    git clone -q "https://github.com/$REPO.git" "$CACHE";
  fi

  if [ ! -z "$1" ];
  then
    if ls "$CACHE/themes" | sed 's/\.yaml$//g' | grep -w "$1" > /dev/null
    then
      theme="$1.yaml"
    else
      echo "No theme named: $1"
      exit 1
    fi
  else
    # use fzf to let the user choose the theme.
    theme=$(alacritty-colorscheme -C "$CACHE/themes" list | fzf)
    if [ "$theme" == "" ]; then
      echo "${Wrn}No theme selected. Aborting.${Off}";
      exit 1
    fi
  fi
  alacritty-colorscheme -C "$CACHE/themes" apply "$theme"
}

main "$@"
