#! /usr/bin/bash
#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

_notify="yes"

error () {
  if [ "$1" = 0 ];
  then
    [ "$_notify" = "yes" ] && notify-send -u low -t 10000 -- "$2"
  else
    [ "$_notify" = "yes" ] && notify-send -u critical -t 10000 -- "$3"
  fi
}

# quick startup sound.
mpv --no-video ~/.local/share/sounds/startup.mp3 &

# open the help only when first time
if command -v conky &> /dev/null; then
  [ ! -f $HOME/.local/share/qtile/nobeginner ] && conky --config ~/.config/qtile/conky/beginner.conkyrc --daemonize #--pause=5
  [ ! -f $HOME/.local/share/qtile/nobeginner ] && conky --config ~/.config/conky/vision/Z333-vision.conkyrc --daemonize #--pause=5
  [ ! -f $HOME/.local/share/qtile/nobeginner ] && touch "$HOME/.local/share/qtile/nobeginner"
fi

# start the `dunst` notification server in the background
if command -v dunst &> /dev/null; then
  dunst -conf ~/.config/dunst/dunstrc &
fi
if command -v nm-applet &> /dev/null; then
  nm-applt &
  error "$?" "nm-applet started successfully" "nm-applet failed to start"
fi
if command -v volumeicon &> /dev/null; then
  volumeicon &
  error "$?" "volumeicon started successfully" "volumeicon failed to start"
fi

# start the compositor
if command -v picom &> /dev/null; then
  picom --experimental-backends -b
  error "$?" "picom started successfully" "picom failed to start"
fi

# choose a random wallpaper
if command -v feh &> /dev/null; then
  feh --randomize /usr/share/backgrounds/* --bg-fill
fi

if command -v xautolock &> /dev/null; then
  xautolock -exit
  xautolock -time 15 -locker ~/scripts/slock.sh &
  xautolock -disable
  [ "$_notify" = "yes" ] && notify-send -u low -t 10000 -- 'LOCK is OFF by default'
fi

# removes the auto saver of x as it makes my laptop crash
xset s 0
xset -dpms

# start the `dunst` notification server in the background
if command -v emacs &> /dev/null; then
  emacs --daemon &
  error "$?" "emacs server started successfully" "emacs server failed to start"
fi

[ "$_notify" = "yes" ] && notify-send -u normal -t 10000 -- "qtile has been fully loaded"
