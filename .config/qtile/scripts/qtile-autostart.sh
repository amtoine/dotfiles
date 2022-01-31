#! /usr/bin/bash

feh --no-fehbg --bg-fill --randomize ~/repos/wallpapers/wallpapers/*

emacs --daemon

killall -q xautolock
xautolock -time 10 -locker ~/scripts/slock-cst.sh &
xset s 0
xset -dpms
