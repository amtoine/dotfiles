#                _       _ __
#          _  __(_)___  (_) /___________
#         | |/_/ / __ \/ / __/ ___/ ___/
#      _ _>  </ / / / / / /_/ /  / /__
#     (_)_/|_/_/_/ /_/_/\__/_/   \___/
#
# full config can be found at: https://github.com/a2n-s/dotfiles


#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

### window manager launching:
# the compositor.
picom &

# the wallpaper.
#nitrogen --restore &
~/.fehbg &

# the screen saver.
xscreensaver --no-splash > /dev/null &

# the window manager itself.
case "$_my_wm" in
    spectrwm) exec spectrwm ;;
    bspwm)    exec bspwm ;;
    i3)       exec i3 ;;
    awesome)  exec awesome ;;
    qtile)    exec qtile start ;;
    *)        exec spectrwm ;;
esac
