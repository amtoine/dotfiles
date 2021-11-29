#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch
#polybar example -c ~/.config/polybar/config.ini &
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example -c ~/.config/polybar/config.ini &
  done
else
  polybar --reload example -c ~/.config/polybar/config.ini &
fi

