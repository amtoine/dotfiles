#!/usr/bin/env bash
#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

show_keymap () {
  #
  # extracts the keymap, put it through dmenu and execute the command
  #
  KEYMAP=$(mktemp /tmp/qtile-keymap.XXXXXX)
  trap 'rm "$KEYMAP"' 0 1 15
  CHORDS=$(mktemp /tmp/qtile-chords.XXXXXX)
  trap 'rm "$CHORDS"' 0 1 15

  # extract the raw keymap from qtile
  python -c "print($(qtile cmd-obj -o cmd -f display_kb))" | tee "$KEYMAP" > /dev/null
  # remove the header  | and  emojis       |  compact keys       ;  <root>      keysym             modifiers          > m+k  ; rm trailing spaces...               after chords      ; treat the special XF86 keys that do not use the SUPER key                                        ; align with '%%' and store in $KEYMAP
  tail -n +3 "$KEYMAP" | tr -d '\200-\377' | sed 's/mod4, /mod4+/; s/<root>\s*\([a-zA-Z0-9]*\)\s*\(mod4[+a-zA-Z0-9]*\)/\2+\1/; s/^\s*//; s/\s*$//g; s/> />/g; s/^\([A-Z>]*\)\s\+/\1+/; s/<root>\s*//; s/^\(XF86[a-zA-z]*\)\s*control/control+\1/; s/^\(XF86[a-zA-z]*\)\s*shift/shift+\1/; s/ \s\+/%%/g' | column -t -s '%%' | tee "$KEYMAP" > /dev/null

  # isolate the keychord entries
  grep "Enter" "$KEYMAP" | awk '{print $3","$1}' | sort -r | tee "$CHORDS" > /dev/null
  # replace them iteratively inside the keymap to get rid of chord names
  for line in $(cat "$CHORDS"); do
    pat=$(echo "$line" | awk -F, '{print $1}')
    rep=$(echo "$line" | awk -F, '{print $2}')
    sed -i "s/$pat/$rep/" "$KEYMAP"
  done
  sed -i 's/>[A-Z]*//; /Enter/d' "$KEYMAP"

  #        realign    ; compact special and long keys
  sed -i 's/ \s\+/%%/g; s/^mod./[S]/; s/shift+/S+/g; s/+comma/+,/; s/+period/+./; s/mod1+/A+/; s/Return+/R+/; s/control+/C+/; s/+space/+" "/' "$KEYMAP"
  #        show 'key' 'desc' 'func' and let the user choose one of them with dmenu                      | separate again to isolate 'func'
  choice=$(awk -F'%%' '{print $1"%%"$3"%%"$2}' "$KEYMAP" | column -t -s '%%' | sort | dmenu -i -l 20 -bw 5 | sed 's/ \s\+/%%/g' | awk -F'%%' '{print $3}')
  [ -n $choice ] && { echo -e "No command selected\nAborting"; exit 0; }
  # func ~ command(arg)
  command=$(echo "$choice" | sed 's/(.*//')
  # remove command() and leading or trailing "" or '' pairs that mess up expansion
  arg=$(echo "$choice" | sed "s/[a-z_-]*(\(.*\))/\1/; s/^'\(.*\)'$/\1/g; s/^\"\(.*\)\"$/\1/g")

  # finally execute the command
  qtile cmd-obj -o cmd -f "$command" -a "$arg"
}

usage () {
  #
  # the usage function.
  #
  echo "Usage: qtile/scripts/km.sh [-h]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "qtile/scripts/km.sh:"
  echo "     show qtile's keymap"
  echo "     and let the user explore and execute qtile"
  echo "     bindings with dmenu."
  echo ""
  echo "Usage:"
  echo "     qtile/scripts/km.sh [-h]"
  echo ""
  echo "Switches:"
  echo "     -h/--help    show this help."
  exit 0
}

# parse the arguments.
OPTIONS=$(getopt -o h --long help -n 'qtile/scripts/km.sh' -- "$@")
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

  show_keymap
}

main "$@"
