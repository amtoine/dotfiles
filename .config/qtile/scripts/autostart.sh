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

# open the help only when first time
if command -v feh &> /dev/null; then
  [ ! -f $HOME/.local/share/qtile/nobeginner ] && conky --config ~/.config/qtile/conky/beginner.conkyrc --daemonize #--pause=5
  [ ! -f $HOME/.local/share/qtile/nobeginner ] && conky --config ~/.config/conky/vision/Z333-vision.conkyrc --daemonize #--pause=5
  [ ! -f $HOME/.local/share/qtile/nobeginner ] && touch $HOME/.local/share/qtile/nobeginner
fi

# start the compositor
if command -v picom &> /dev/null; then picom -b; fi

# choose a random wallpaper
if command -v feh &> /dev/null; then
  feh --randomize \
    ~/repos/wallpapers/wallpapers/* \
    ~/repos/catppucin/wallpapers/minimalistic/* \
    ~/repos/catppucin/wallpapers/mandelbrot/* \
    --no-fehbg --bg-fill
fi

# start emacs in the background
if command -v emacs &> /dev/null; then emacs --daemon; fi

# start the `dunst` notification server in the background
if command -v dunst &> /dev/null; then
  dunst -conf ~/.config/dunst/dunstrc &
fi

if command -v killall &> /dev/null; then killall -q xautolock; fi
if command -v xautolock &> /dev/null; then
  xautolock -time 10 -locker ~/scripts/slock-cst.sh &
fi

# removes the auto saver of x as it makes my laptop crash
xset s 0
xset -dpms
