#! /usr/bin/bash

feh --bg-fill --randomize ~/repos/wallpapers/wallpapers/

killall -q xautolock
xautolock -time 10 -locker ~/scripts/slock-cst.sh &
xset s 0
xset -dpms
