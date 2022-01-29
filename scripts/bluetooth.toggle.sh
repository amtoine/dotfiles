#!/usr/bin/env bash
#           ___
#      __ _|_  )_ _    ___   ___        personal page: https://a2n-s.github.io/
#     / _` |/ /| ' \  |___| (_-<        github   page: https://github.com/a2n-s
#     \__,_/___|_||_|       /__/        my   dotfiles: https://github.com/a2n-s/dotfiles
#                 _      _          __  _    _          _            _   _          _                  _              _
#      ___ __ _ _(_)_ __| |_ ___   / / | |__| |_  _ ___| |_ ___  ___| |_| |_       | |_ ___  __ _ __ _| |___       __| |_
#     (_-</ _| '_| | '_ \  _(_-<  / /  | '_ \ | || / -_)  _/ _ \/ _ \  _| ' \   _  |  _/ _ \/ _` / _` | / -_)  _  (_-< ' \
#     /__/\__|_| |_| .__/\__/__/ /_/   |_.__/_|\_,_\___|\__\___/\___/\__|_||_| (_)  \__\___/\__, \__, |_\___| (_) /__/_||_|
#                  |_|                                                                      |___/|___/
#

[[ ! -v DEVICE ]] && DEVICE="JBL Xtreme"
[[ ! -v ON ]] && ON="a2dp_sink"
[[ ! -v OFF ]] && OFF="off"
NUM=$(pacmd list-cards | grep -B5 "$DEVICE" | head -1 | sed 's/\s\+index: //')

on () {
    echo "device ($1) on"
    pacmd set-card-profile "$1" $ON
}

off () {
    echo "device ($1) off"
    pacmd set-card-profile "$1" $OFF
}

toggle () {
    if pacmd list-cards | grep -B5 "$DEVICE" | grep 'active profile'
    then
        off "$1"
    else
        on "$1"
    fi
}

main () {
    while getopts ":oOt" o; do
        case "${o}" in
            t) toggle "$NUM"; exit 0;;
            O) on "$NUM"; exit 0;;
            o) off "$NUM"; exit 0;;
            *) echo "unknow flag ${o}"; exit 1;;
        esac
    done
}

main "$@"
