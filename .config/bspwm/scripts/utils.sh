#!/usr/bin/env bash

XDG_STATE=${XDG_STATE_HOME:-$HOME/.local/state}
[ ! -d "$XDG_STATE/bspwm/" ] && mkdir "$XDG_STATE/bspwm/"
LOG_FILE="$XDG_STATE/bspwm/bspwm.log"
[ ! -f "$LOG_FILE" ] && touch "$LOG_FILE"


timestamp () {
    date +"[%y/%m/%d][%H:%M:%S][%N]"
}


log_any () {
    echo "[$1]$(timestamp)$3 $2" | tee -a "$LOG_FILE";
}


log_err () {
    log_any "ERROR.." "$1" "$2"
}


log_warning () {
    log_any "WARNING" "$1" "$2"
}


log_debug () {
    log_any "DEBUG.." "$1" "$2"
}


log_info () {
    log_any "INFO..." "$1" "$2"
}


log_ok () {
    log_any "OK....." "$1" "$2"
}
