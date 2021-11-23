#          _               _                                 __ _ _
#         | |             | |                               / _(_) |
#         | |__   __ _ ___| |__             _ __  _ __ ___ | |_ _| | ___
#         | '_ \ / _` / __| '_ \           | '_ \| '__/ _ \|  _| | |/ _ \
#      _  | |_) | (_| \__ \ | | |          | |_) | | | (_) | | | | |  __/
#     (_) |_.__/ \__,_|___/_| |_|          | .__/|_|  \___/|_| |_|_|\___|
#                                  ______  | |
#                                 |______| |_|
#
# full config can be found at: https://github.com/a2n-s/dotfiles

_my_wm="spectrwm"
if [[ $(fgconsole 2> /dev/null) == 1 ]]; then
    echo "Starting x..."
    exec startx -- vt1;
else
  [[ -f ~/.bashrc ]] && . ~/.bashrc
fi
