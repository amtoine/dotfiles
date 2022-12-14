#!/usr/bin/bash
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

source "$HOME/.config/bspwm/scripts/utils.sh"

autostart () {
    # restart sxhkd.
    killall sxhkd
    sxhkd -c "$WM_SXHKD_COMMON" "$WM_SXHKD_BSPWM" &

    # start the `dunst` notification server in the background
    if [ -n "$WM_USE_DUNST" ]; then
      if does_command_exist dunst; then
        log_info "dunst..." "[scripts.autostart]"
        kill_if_running dunst
        if dunst -conf ~/.config/dunst/dunstrc &
        then
          notify_ok "dunst started successfully"
        else
          notify_err "dunst failed to start"
        fi
      else
        log_warning "dunst not found in \$PATH"
      fi
    else
      log_info "do not use dunst"
    fi

    if [ -n "$WM_USE_POLYBAR" ]; then
      if does_command_exist polybar; then
        log_info "polybar..." "[scripts.autostart]"
        if bash "$WM_POLYBAR" --"$WM_POLYBAR_THEME" &
        then
          notify_ok "polybar started successfully"
        else
          notify_err "polybar failed to start"
        fi
      else
        log_warning "polybar not found in \$PATH"
      fi
    else
      log_info "do not use polybar"
    fi

    # open the help only when first time
    if [ -n "$WM_USE_CONKY" ]; then
      if does_command_exist conky; then
        log_info "conky..." "[scripts.autostart]"
        kill_if_running conky
        run_conky
        log_ok "conky done!" "[scripts.autostart]"
      else
        log_warning "conky not found in \$PATH"
      fi
    else
      log_info "do not use conky"
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
      else
        log_warning "nm-applet not found in \$PATH"
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
      else
        log_warning "volumeicon not found in \$PATH"
      fi
    else
        log_info "do not use a systray"
        kill_if_running nm-applt
        kill_if_running volumeicon
    fi

    # start the compositor
    if [ -n "$WM_USE_PICOM" ]; then
      if does_command_exist picom; then
        log_info "picom..." "[scripts.autostart]"
        kill_if_running picom
        if picom --experimental-backends --daemon --animations
        then
          notify_ok "picom started successfully"
        else
          notify_err "picom failed to start"
        fi
      else
        log_warning "picom not found in \$PATH"
      fi
    else
      log_info "do not use picom"
    fi

    # choose a random wallpaper
    if [ -n "$WM_SET_WALLPAPERS" ]; then
      if does_command_exist feh; then
        log_info "feh..." "[scripts.autostart]"
        if feh --randomize /usr/share/backgrounds/* --bg-fill --no-fehbg
        then
          notify_ok "wallpaper(s) set"
        else
          notify_err "wallpaper(s) not set"
        fi
      else
        log_warning "feh not found in \$PATH"
      fi
    else
      log_info "do not set wallpapers"
    fi

    # start the autolock
    if [ -n "$WM_USE_AUTOLOCK" ]; then
      if does_command_exist xautolock; then
        xautolock -exit
        xautolock -time 15 -locker "$LOCKER" &
        error "$?" "xautolock started successfully" "xautolock failed to start"
        xautolock -disable
        [ -n "$WM_NOTIFY_AT_STARTUP" ] && notify-send -u low -t 10000 -- 'LOCK is OFF by default'
      else
        log_warning "xautolock not found in \$PATH"
      fi
    else
      log_info "do not use an autolock"
    fi

    # hide the mouse
    if [ -n "$WM_USE_UNCLUTTER" ]; then
      if does_command_exist unclutter; then
        log_info "unclutter..." "[scripts.autostart]"
        kill_if_running unclutter
        if unclutter --timeout 2 --jitter 100 --start-hidden &
        then
          notify_ok "unclutter started successfully"
        else
          notify_err "unclutter failed to start"
        fi
      else
        log_warning "unclutter not found in \$PATH"
      fi
    else
      log_info "do not hide the mouse"
    fi

    # remove the auto saver of x
    if [ -z "$WM_USE_AUTOSAVER" ]; then
      log_info "xset..." "[scripts.autostart]"
      xset s 0
      xset -dpms
      log_ok "xset done!" "[scripts.autostart]"
    fi


    if [ -n "$WM_USE_MOC" ]; then
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
      else
        log_warning "mocp not found in \$PATH"
      fi
    else
      log_info "do not use mocp"
    fi

    # start the `emacs` server in the background
    if [ -n "$WM_USE_EMACS" ]; then
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
      else
        log_warning "emacs not found in \$PATH"
      fi
    else
      log_info "do not use emacs"
    fi
}

poststart () {
    if [ -n "$WM_PULL_GITHUB" ]; then
        if does_command_exist gghn; then
            gghn
        else
            log_warning "gghn not found in \$PATH"
        fi
    fi


    if [ -n "$WM_PULL_UPDATES" ]; then
        if does_command_exist gsupdate; then
            gsupdate --check
        else
            log_warning "gsupdate not found in \$PATH"
        fi
    fi
}
