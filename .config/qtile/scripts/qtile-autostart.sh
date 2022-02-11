#! /usr/bin/bash

conky --config ~/.config/qtile/conky/beginner.conkyrc --daemonize #--pause=5
conky --config ~/.config/conky/vision/Z333-vision.conkyrc --daemonize #--pause=5
feh --randomize \
  ~/repos/wallpapers/wallpapers/* \
  ~/repos/catppucin/wallpapers/minimalistic/* \
  ~/repos/catppucin/wallpapers/mandelbrot/* \
  --no-fehbg --bg-fill

emacs --daemon

killall -q xautolock
xautolock -time 10 -locker ~/scripts/slock-cst.sh &
xset s 0
xset -dpms
