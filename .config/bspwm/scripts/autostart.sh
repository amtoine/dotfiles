#!/usr/bin/bash
#           ___
#      __ _|_  )_ _ ___ ___   personal page: https://a2n-s.github.io/
#     / _` |/ /| ' \___(_-<   github   page: https://github.com/a2n-s
#     \__,_/___|_||_|  /__/   my   dotfiles: https://github.com/a2n-s/dotfiles
#               __  _        __         __            _          _            _        _
#        __    / / | |__    / /  ___   / /  __ _ _  _| |_ ___ __| |_ __ _ _ _| |_   __| |_
#      _/ _|  / /  | '_ \  / /  (_-<  / /  / _` | || |  _/ _ (_-<  _/ _` | '_|  _|_(_-< ' \
#     (_)__| /_/   |_.__/ /_/   /__/ /_/   \__,_|\_,_|\__\___/__/\__\__,_|_|  \__(_)__/_||_|
#
# Description:  my autostart script for bspwm.
# Dependencies: feh, emacs, polybar, dunst, mpv
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine



error () {
  # Print an error or a success message depending on last command's success.
  #
  # Args:
  #   $1: the last exit signal.
  #   $2: the success message.
  #   $3: the error message.
  #
  if [ "$1" = 0 ];
  then
    [ -n "$WM_NOTIFY_AT_STARTUP" ] && dunstify -u low -t 10000 -- "$2"
  else
    [ -n "$WM_NOTIFY_AT_STARTUP" ] && dunstify -u critical -t 10000 -- "$3"
  fi
}

does_command_exist () {
  # Check if a command exist on the system.
  #
  # Args:
  #   $1: the name of the command.
  #
  # Returns:
  #   code: the same error code, saying whether the command exists or not.
  command -v "$1" &> /dev/null
}

kill_if_running () {
  # Kill a program only if running.
  #
  # Args:
  #   $1: the program to kill.
  #
  if pgrep -f "$1" 1> /dev/null; then
    killall "$1"
  fi
}

NO_BEGINNER="$HOME/.local/share/bspwm/nobeginner"
run_conky () {
  # Run all the conky needed by bspwm, only once.
  #
  # Now, there is a help conky at $CONKY_HELP and a clock at $CONKY_CLOCK.
  #
  if [ ! -f "$NO_BEGINNER" ]; then
    conky --config "$WM_CONKY_HELP" --daemonize
    conky --config "$WM_CONKY_CLOCK" --daemonize
    mkdir -p "$(dirname "$NO_BEGINNER")"
    touch "$NO_BEGINNER"
  fi
}

# restart sxhkd.
killall sxhkd
sxhkd -c "$WM_SXHKD_COMMON" "$WM_SXHKD_BSPWM" &

# start the `dunst` notification server in the background
if does_command_exist dunst; then
  kill_if_running dunst
  dunst -conf ~/.config/dunst/dunstrc &
  error "$?" "dunst started successfully" "dunst failed to start"
fi

if does_command_exist polybar && [ -n "$WM_USE_POLYBAR" ]; then
  bash "$WM_POLYBAR" --"$WM_POLYBAR_THEME" &
  error "$?" "polybar started successfully" "polybar failed to start"
fi

# open the help only when first time
if does_command_exist conky; then
  kill_if_running conky
  run_conky
fi

if [ -n "$WM_USE_SYSTRAY" ]; then
  if does_command_exist nm-applet; then
    kill_if_running nm-applt
    nm-applt &
    error "$?" "nm-applet started successfully" "nm-applet failed to start"
  fi
  if does_command_exist volumeicon; then
    kill_if_running volumeicon
    volumeicon &
    error "$?" "volumeicon started successfully" "volumeicon failed to start"
  fi
else
    kill_if_running nm-applt
    kill_if_running volumeicon
fi

# start the compositor
if does_command_exist picom; then
  kill_if_running picom
  picom --experimental-backends --daemon --animations
  error "$?" "picom started successfully" "picom failed to start"
fi

# choose a random wallpaper
if does_command_exist feh; then
  feh --randomize /usr/share/backgrounds/* --bg-fill --no-fehbg
  error "$?" "wallpaper(s) set" "wallpaper(s) not set"
fi

# start the autolock
if does_command_exist xautolock; then
  xautolock -exit
  xautolock -time 15 -locker "$LOCKER" &
  error "$?" "xautolock started successfully" "xautolock failed to start"
  xautolock -disable
  [ -n "$WM_NOTIFY_AT_STARTUP" ] && notify-send -u low -t 10000 -- 'LOCK is OFF by default'
fi

# removes the auto saver of x as it makes my laptop crash
xset s 0
xset -dpms

if does_command_exist moc; then
  if ! pgrep -f "mocp" 1> /dev/null; then
    mocp -S
    error "$?" "moc server started successfully" "moc server failed to start"
  fi
fi

# start the `emacs` server in the background
if does_command_exist emacs; then
  if ! pgrep -f "emacs --daemon" 1> /dev/null; then
    emacs --daemon &
    error "$?" "emacs server started successfully" "emacs server failed to start"
  fi
fi

# bspwm has been completely started
[ -n "$WM_NOTIFY_AT_STARTUP" ] && dunstify -u normal -t 10000 -- "bspwm has been fully loaded"
[ -n "$WM_PLAY_STARTUP_SOUND" ] && mpv --no-video "$WM_STARTUP_SOUND" &
