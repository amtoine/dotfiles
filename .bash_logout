#          _               _                _                         _
#         | |             | |              | |                       | |
#         | |__   __ _ ___| |__            | | ___   __ _  ___  _   _| |_
#         | '_ \ / _` / __| '_ \           | |/ _ \ / _` |/ _ \| | | | __|
#      _  | |_) | (_| \__ \ | | |          | | (_) | (_| | (_) | |_| | |_
#     (_) |_.__/ \__,_|___/_| |_|          |_|\___/ \__, |\___/ \__,_|\__|
#                                  ______            __/ |
#                                 |______|          |___/
# full config can be found at: https://github.com/a2n-s/dotfiles

# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

echo ".bash_logout"
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
