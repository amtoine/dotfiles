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


source "$HOME/.config/bspwm/scripts/utils.sh"

notify_ok () {
  [ -n "$WM_NOTIFY_AT_STARTUP" ] && dunstify -u low -t 10000 -- "$1"
  log_ok "$1" "[scripts.autostart]"
}

notify_err () {
  [ -n "$WM_NOTIFY_AT_STARTUP" ] && dunstify -u critical -t 10000 -- "$1"
  log_err "$1" "[scripts.autostart]"
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
  log_info "dunst..." "[scripts.autostart]"
  kill_if_running dunst
  if dunst -conf ~/.config/dunst/dunstrc &
  then
    notify_ok "dunst started successfully"
  else
    notify_err "dunst failed to start"
  fi
fi

if does_command_exist polybar && [ -n "$WM_USE_POLYBAR" ]; then
  log_info "polybar..." "[scripts.autostart]"
  if bash "$WM_POLYBAR" --"$WM_POLYBAR_THEME" &
  then
    notify_ok "polybar started successfully"
  else
    notify_err "polybar failed to start"
  fi
fi

# open the help only when first time
if does_command_exist conky; then
  log_info "conky..." "[scripts.autostart]"
  kill_if_running conky
  run_conky
  log_ok "conky done!" "[scripts.autostart]"
fi

if [ -n "$WM_USE_SYSTRAY" ]; then
  if does_command_exist nm-applet; then
    log_info "nm-applet..." "[scripts.autostart]"
    kill_if_running nm-applet
    if nm-applet &
    then
      notify_ok "nm-applet started successfully"
    else
      notify_err "nm-applet failed to start"
    fi
  fi
  if does_command_exist volumeicon; then
    log_info "volumeicon..." "[scripts.autostart]"
    kill_if_running volumeicon
    if volumeicon &
    then
      notify_ok "volumeicon started successfully"
    else
      notify_err "volumeicon failed to start"
    fi
  fi
else
    kill_if_running nm-applt
    kill_if_running volumeicon
fi

# start the compositor
if does_command_exist picom; then
  log_info "picom..." "[scripts.autostart]"
  kill_if_running picom
  if picom --experimental-backends --daemon --animations
  then
    notify_ok "picom started successfully"
  else
    notify_err "picom failed to start"
  fi
fi

# choose a random wallpaper
if does_command_exist feh; then
  log_info "feh..." "[scripts.autostart]"
  if feh --randomize /usr/share/backgrounds/* --bg-fill --no-fehbg
  then
    notify_ok "wallpaper(s) set"
  else
    notify_err "wallpaper(s) not set"
  fi
fi

# # start the autolock
# if does_command_exist xautolock; then
#   xautolock -exit
#   xautolock -time 15 -locker "$LOCKER" &
#   error "$?" "xautolock started successfully" "xautolock failed to start"
#   xautolock -disable
#   [ -n "$WM_NOTIFY_AT_STARTUP" ] && notify-send -u low -t 10000 -- 'LOCK is OFF by default'
# fi

if does_command_exist unclutter; then
  log_info "unclutter..." "[scripts.autostart]"
  kill_if_running unclutter
  if unclutter --timeout 2 --jitter 100 --start-hidden &
  then
    notify_ok "unclutter started successfully"
  else
    notify_err "unclutter failed to start"
  fi
fi

# removes the auto saver of x as it makes my laptop crash
log_info "xset..." "[scripts.autostart]"
xset s 0
xset -dpms
log_ok "xset done!" "[scripts.autostart]"

if does_command_exist moc; then
  if ! pgrep -f "mocp" 1> /dev/null; then
    log_info "moc..." "[scripts.autostart]"
    if mocp -S
    then
      notify_ok "moc server started successfully"
    else
      notify_err "moc server failed to start"
    fi
  else
    notify_ok "moc server already running"
  fi
fi

# start the `emacs` server in the background
if does_command_exist emacs; then
  if ! pgrep -f "emacs --daemon" 1> /dev/null; then
    log_info "emacs..." "[scripts.autostart]"
    if emacs --daemon &
    then
      notify_ok "emacs server started successfully"
    else
      notify_err "emacs server failed to start"
    fi
  else
    notify_ok "emacs server already running"
  fi
fi
