#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#        _     __  _        __                  _      _                      _
#       | |   / / | |__    / /  __ ___ _  _ _ _| |_ __| |_____ __ ___ _    __| |_
#      _| |  / /  | '_ \  / /  / _/ _ \ || | ' \  _/ _` / _ \ V  V / ' \ _(_-< ' \
#     (_)_| /_/   |_.__/ /_/   \__\___/\_,_|_||_\__\__,_\___/\_/\_/|_||_(_)__/_||_|
#
# Description:  simple countdown
# Dependencies: play, dunst
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o ht: --long help,time: -n 'countdown.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# allow the user to change the environment variables.
[[ ! -v DUNST_ID ]] && DUNST_ID=4

_compute_progress () {
    # Compute the progress of the current countdown.
    #
    # Args:
    #   $1: the current time, in seconds.
    #   $2: the total time, in seconds.
    #
    # Returns:
    #   progress: the progress, in percent.
    progress=$(awk -v c="$1" -v t="$2" 'BEGIN { print 100 * c / t }')
    echo "$progress"
}


ring () {
    for _ in $(seq 3); do
        for _ in $(seq 5); do
            play -q -n synth .1 sine 880 vol 0.5
        done
        sleep .5
    done
}


countdown () {
    for t in $(seq 0 "$1" | tac); do
        progress=$(_compute_progress "$t" "$1")
        dunstify --urgency low "countdown.sh" "total:${1}s\nremaining:${t}s" -h "int:value:$progress" --replace "$DUNST_ID"
        sleep 1
    done
    dunstify --urgency normal "countdown.sh" "time is over" --replace "$DUNST_ID"
}


usage () {
  #
  # the usage function.
  #
  echo "Usage: countdown.sh [-h] -t TIME"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "battery.sh:"
  echo "     a script to launch a countdown, displayed as notifications, and with a bell at the end."
  echo ""
  echo "Usage:"
  echo "     countdown.sh [-h] -t TIME"
  echo ""
  echo "Switches:"
  echo "     -h/--help             shows this help."
  echo "     -t/--time             the total duration of the countdown, in seconds."
  echo ""
  echo "Environment variables:"
  echo "     DUNST_ID              the id of the countdown notifications, to replace them properly (defaults to 4)"
  exit 0
}

main () {
  ACTION=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help )   help ;;
      -t | --time )   ACTION="count down"; TIME="$2"; shift 2 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  # an action is required
  [ -z "$ACTION" ] && usage
  [ -z "$TIME" ] && usage
  if [ "$TIME" -gt 0 ]; then
      countdown "$TIME"
      ring
  else
      dunstify --urgency critical --timeout 5000 "countdown.sh" "Please provide a time as the only argument"
  fi
}

main "$@"
