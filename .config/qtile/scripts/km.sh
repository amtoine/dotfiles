#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#               __           __         __  _              _
#        __    / /  __ _    / /  ___   / / | |___ __    __| |_
#      _/ _|  / /  / _` |  / /  (_-<  / /  | / / '  \ _(_-< ' \
#     (_)__| /_/   \__, | /_/   /__/ /_/   |_\_\_|_|_(_)__/_||_|
#                     |_|
#
# Description:  TODO
# Dependencies: TODO
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
################################################################################################
## 'Global constants' definitions ##############################################################
################################################################################################
# Specific color use. #
#######################
Ok=$Grn    # ok statement
Err=$IRed  # errors
Wrn=$IYlw  # warnings
Cod=$IBlu  # code
Hed=$IPur  # head
Src=$Pur   # source
Dst=$Grn   # destination
Pmt=$Cyn   # prompt
Tip=$IGrn  # tip

[[ ! -v VAR ]] && VAR="DEFAULT"

func () {
  #
  # TODO
  #
  echo "this is an example function (VAR='$VAR')"
}


usage () {
  #
  # the usage function.
  #
  echo "Usage: ****.sh [-h]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "****.sh:"
  echo "     TODO"
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     ****.sh [-h]"
  echo ""
  echo "Switches:"
  echo "     -h/--help           shows this help."
  echo ""
  echo "Environment variables:"
  echo "     VAR                 an environment variable (defaults to 'DEFAULT')"
  exit 0
}

# parse the arguments.
OPTIONS=$(getopt -o h --long help -n '****.sh' -- "$@")
if [ $? != 0 ] ; then usage >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  python -c "print(`qtile cmd-obj -o cmd -f display_kb`)" | tee /tmp/qtile.kb > /dev/null
  tail -n +3 /tmp/qtile.kb | tr -d '\200-\377' | sed 's/mod4, /mod4+/; s/<root>\s*\([a-zA-Z0-9]*\)\s*\(mod4[+a-zA-Z0-9]*\)/\2+\1/; s/^\s*//; s/> />/g; s/^\([A-Z>]*\)\s\+/\1+/; s/ \s\+/%%/g; s/\s*$//g' | column -t -s '%%' | tee /tmp/qtile.kb2 > /dev/null
  cat /tmp/qtile.kb2 | grep Enter | awk '{print $3","$1}' | sort -r | tee /tmp/qtile.kb3 > /dev/null
  cp /tmp/qtile.kb2 /tmp/qtile.kb4
  for line in $(cat /tmp/qtile.kb3); do
    pat=$(echo "$line" | awk -F, '{print $1}')
    rep=$(echo "$line" | awk -F, '{print $2}')
    sed -i "s/$pat/$rep/" /tmp/qtile.kb4
  done
  sed -i 's/>[A-Z]*//; /Enter/d' /tmp/qtile.kb4
  sed 's/ \s\+/%%/g; s/+shift/+S/g; s/+comma/+,/; s/+period/+./; s/^[a-z0-9]*/[S]/;; s/+mod1/+A/; s/+Return/+R/; s/+control/+C/; s/+space/+" "/' /tmp/qtile.kb4 | tee /tmp/qtile.kb5 > /dev/null
  choice=$(awk -F'%%' '{print $1"%%"$3"%%"$2}' /tmp/qtile.kb5 | column -t -s '%%' | sort | dmenu -l 20 -bw 5 | sed 's/ \s\+/%%/g' | awk -F'%%' '{print $3}')
  command=$(echo "$choice" | sed 's/(.*//')
  arg=$(echo "$choice" | sed "s/[a-z_-]*(\(.*\))/\1/")

  if [ "$arg" = "" ]; then
    echo qtile cmd-obj -o cmd -f "$command"
    qtile cmd-obj -o cmd -f "$command"
  else
    echo qtile cmd-obj -o cmd -f $command -a "$arg"
    qtile cmd-obj -o cmd -f $command -a "$arg"
  fi
  
}

main "$@"
