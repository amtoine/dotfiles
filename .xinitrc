#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                _       _ __
#          _  __(_)___  (_) /___________
#         | |/_/ / __ \/ / __/ ___/ ___/
#      _ _>  </ / / / / / /_/ /  / /__
#     (_)_/|_/_/_/ /_/_/\__/_/   \___/
#
# Description:  my x config.
# Dependencies: picom, feh, a wm, xscreensaver.
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine


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
#~/.fehbg &
feh --bg-fill --randomize ~/repos/wallpapers/wallpapers/
# the screen saver.
# xscreensaver --no-splash > /dev/null &

# the window manager itself.
# exec spectrwm
exec bspwm
# exec i3
# exec awesome
# exec qtile start
# exec spectrwm
