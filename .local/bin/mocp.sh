#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#        _     __  _        __                          _
#       | |   / / | |__    / /  _ __  ___  __ _ __   __| |_
#      _| |  / /  | '_ \  / /  | '  \/ _ \/ _| '_ \_(_-< ' \
#     (_)_| /_/   |_.__/ /_/   |_|_|_\___/\__| .__(_)__/_||_|
#                                            |_|
#
# Description:  give information about the current moc server.
# Dependencies: mocp
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

# parse the arguments
OPTIONS=$(getopt -o fh --long follow,help \
              -n 'mocp.sh' -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

# environment variables.
[[ ! -v ICONS ]] && ICONS="/usr/share/icons/a2n-s-icons"
[[ ! -v DUNST_ID ]] && DUNST_ID=3
[[ ! -v FOLLOW_SLEEP ]] && FOLLOW_SLEEP=1
[[ ! -v FOLLOW_LOOPS ]] && FOLLOW_LOOPS=10

_get_mocp_info () {
    # Get a keyword info from the moc server.
    #
    # Arge:
    #   $1: the pattern to grab, e.g. "Artist" or "Title".
    #
    # Returns:
    #   info: the info given by moc.

    # lines are uniquely identified with the "$1:" pattern at the
    # beginning of each line.
    # do not forget to remove it to keep the info.
    info=$(mocp -i | grep "^$1:" | sed "s/^$1: //")
    echo "$info"
}


_compute_progress () {
    # Compute the progress of the current song.
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


_compute_icon () {
    # Compute the appropriate notification icon based on the state of the server.
    #
    # Args:
    #   $1: the state of the server, namely "PLAY" or "PAUSE".
    #
    # Returns:
    #   icons: the appropriate icon.
    state="$1"
    if [ "$state" = "PLAY" ]; then
        icon="$ICONS/audio-music.png"
    elif [ "$state" = "PAUSE" ]; then
        icon="$ICONS/audio-stop.png"
    else
        icon="$ICONS/notification-critical.png"
    fi
    echo "$icon"
}

show_moc_server_once () {
    # Throw one notification with the state of the MOC server.
    total_sec=$(_get_mocp_info "TotalSec")
    current_sec=$(_get_mocp_info "CurrentSec")
    total_time=$(_get_mocp_info "TotalTime")
    current_time=$(_get_mocp_info "CurrentTime")
    progress=$(_compute_progress "$current_sec" "$total_sec")
    dunstify "mocp.sh" "$title\n$current_time/$total_time" -h "int:value:$progress" -u low --icon="$icon" --replace="$DUNST_ID"
}

follow () {
    # Show the MOC server once... but for many times.
    for _ in $(seq "$FOLLOW_LOOPS"); do
        show_moc_server_once
        sleep "$FOLLOW_SLEEP"
    done
    dunstify --close="$DUNST_ID"
}

usage () {
  #
  # the usage function.
  #
  echo "Usage: mocp.sh [-hf]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "mocp.sh:"
  echo "     show the current state of the MOC server."
  echo ""
  echo "Usage:"
  echo "     mocp.sh [-hf]"
  echo ""
  echo "Switches:"
  echo "     -h/--help               shows this help."
  echo "     -f/--follow             follow the song instead of showing a single notification."
  echo ""
  echo "Environment variables:"
  echo "     ICONS                   the path the the icons (defaults to '/usr/share/icons/a2n-s-icons')"
  echo "     DUNST_ID                the id of the dunst notification to be replaced (defaults to 3)"
  echo "     FOLLOW_SLEEP            the time to sleep between two server polls when following (defaults to 1)"
  echo "     FOLLOW_LOOPS            the number of time to follow the server (defaults to 10)"
  exit 0
}

main () {
  ACTION=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help )      help ;;
      -f | --follow )    ACTION="follow"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done

  # get all the useful data from the moc server.
  state=$(_get_mocp_info "State")
  title=$(_get_mocp_info "Title")

  # state won't be set if the server is not running, quit properly.
  [ -z "$state" ] && { dunstify "mocp.sh" "server is not running" -u critical -t 5000 --icon="$ICONS/audio-mute.png"; exit 1; }

  # otherwise show a nice notification.
  icon="$(_compute_icon "$state")"
  if [ "$ACTION" = "follow" ]; then
      follow
    else
      show_moc_server_once
    fi
}

main "$@"
