#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __         __            _          _            _        _
#          __    / /  __ _    / /  ___   / /  __ _ _  _| |_ ___ __| |_ __ _ _ _| |_   __| |_
#      _  / _|  / /  / _` |  / /  (_-<  / /  / _` | || |  _/ _ (_-<  _/ _` | '_|  _|_(_-< ' \
#     (_) \__| /_/   \__, | /_/   /__/ /_/   \__,_|\_,_|\__\___/__/\__\__,_|_|  \__(_)__/_||_|
#                       |_|
#
# Description:  autostarts some process in the background
# Dependencies: picom, feh, emacs, dunst
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

_notify="yes"

error () {
  if [ "$1" = 0 ];
  then
    [ "$_notify" = "yes" ] && notify-send -u low -t 10000 -- "$2"
  else
    [ "$_notify" = "yes" ] && notify-send -u critical -t 10000 -- "$3"
  fi
}

# open the help only when first time
if command -v feh &> /dev/null; then
  [ ! -f $HOME/.local/share/qtile/nobeginner ] && conky --config ~/.config/qtile/conky/beginner.conkyrc --daemonize #--pause=5
  [ ! -f $HOME/.local/share/qtile/nobeginner ] && conky --config ~/.config/conky/vision/Z333-vision.conkyrc --daemonize #--pause=5
  [ ! -f $HOME/.local/share/qtile/nobeginner ] && touch $HOME/.local/share/qtile/nobeginner
fi

# start the `dunst` notification server in the background
if command -v dunst &> /dev/null; then
  dunst -conf ~/.config/dunst/dunstrc &
fi

# start the compositor
if command -v picom &> /dev/null; then
  picom -b
  error "$?" "picom started successfully" "picom failed to start"
fi

# choose a random wallpaper
if command -v feh &> /dev/null; then
  feh --randomize \
    ~/repos/wallpapers/wallpapers/* \
    ~/repos/catppucin/wallpapers/minimalistic/* \
    ~/repos/catppucin/wallpapers/mandelbrot/* \
    --no-fehbg --bg-fill
fi

# start emacs in the background
# if command -v emacs &> /dev/null; then
#   emacs --daemon
#   error "$?" "Emacs started successfully" "Emacs failed to start"
# fi

if command -v xautolock &> /dev/null; then
  margin=60
  xautolock -exit
  xautolock -time 15 -locker ~/scripts/slock.sh -notify "$margin" -notifier "dunstify -u critical -t ${margin}000 'Locking in less than $margin sec...'" &
  xautolock -disable
  [ "$_notify" = "yes" ] && notify-send -u low -t 10000 -- 'LOCK is OFF by default'
fi

# removes the auto saver of x as it makes my laptop crash
xset s 0
xset -dpms

[ "$_notify" = "yes" ] && notify-send -u normal -t 10000 -- "qtile has been fully loaded"
