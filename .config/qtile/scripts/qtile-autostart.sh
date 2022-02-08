#! /usr/bin/bash

feh --no-fehbg --bg-fill --randomize ~/repos/wallpapers/wallpapers/*
conky --config ~/.config/qtile/conky/beginner.conkyrc --daemonize #--pause=5
conky --config ~/.config/conky/vision/Z333-vision.conkyrc --daemonize #--pause=5

emacs --daemon

killall -q xautolock
xautolock -time 10 -locker ~/scripts/slock-cst.sh &
xset s 0
xset -dpms
