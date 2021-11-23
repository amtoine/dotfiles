#! /usr/bin/bash
#                        _       __             __       __                                          ___ __                         _____             _____ __                       __
#        _______________(_)___  / /______     _/_/  ____/ /___ ___  ___  ____  __  __      ___  ____/ (_) /_      _________  ____  / __(_)___ _      / __(_) /__  _____        _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __  / __ `__ \/ _ \/ __ \/ / / /_____/ _ \/ __  / / __/_____/ ___/ __ \/ __ \/ /_/ / __ `/_____/ /_/ / / _ \/ ___/       / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / / / / / /  __/ / / / /_/ /_____/  __/ /_/ / / /_/_____/ /__/ /_/ / / / / __/ / /_/ /_____/ __/ / /  __(__  )  _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \__,_/_/ /_/ /_/\___/_/ /_/\__,_/      \___/\__,_/_/\__/      \___/\____/_/ /_/_/ /_/\__, /     /_/ /_/_/\___/____/  (_)  /____/_/ /_/
#                     /_/                                                                                                             /____/
#
# full config at https://github.com/a2n-s/dotfiles
term="alacritty"
editor="vim"

msg="What config do you want to edit?"
choices="alacritty\nbash\ngit\nhtop\nneofetch\nspectrWM\ntmux\nvifm\nvim\nx\nxscreensaver"
chosen=$(echo -e "$choices" | dmenu -i -p "$msg")

case "$chosen" in 
    alacritty) "$term" -e "$editor" "$HOME/.config/alacritty/alacritty.yml" ;;
    bash) "$term" -e "$editor" "$HOME/.bashrc" ;;
    git) "$term" -e "$editor" "$HOME/.gitconfig" ;;
    htop) "$term" -e "$editor" "$HOME/.config/htop/htoprc" ;;
    neofetch) "$term" -e "$editor" "$HOME/.config/neofetch/config.conf" ;;
    spectrWM) "$term" -e "$editor" "$HOME/.config/spectrwm/spectrwm.conf" ;;
    tmux) "$term" -e "$editor" "$HOME/.tmux.conf" ;;
    vifm) "$term" -e "$editor" "$HOME/.config/vifm/vifmrc" ;;
    vim) "$term" -e "$editor" "$HOME/.vimrc" ;;
    x) "$term" -e "$editor" "$HOME/.xinitrc" ;;
    xscreensaver) "$term" -e "$editor" "$HOME/.xscreensaver" ;;
esac
