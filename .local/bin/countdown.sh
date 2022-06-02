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


if [ "$1" -gt 0 ]; then
    countdown "$1"
    ring
else
    dunstify --urgency critical --timeout 5000 "countdown.sh" "Please provide a time as the only argument"
fi
