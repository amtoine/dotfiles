#           __               __         __                        __
#          / /_  ____ ______/ /_       / /___  ____ _____  __  __/ /_
#         / __ \/ __ `/ ___/ __ \     / / __ \/ __ `/ __ \/ / / / __/
#      _ / /_/ / /_/ (__  ) / / /    / / /_/ / /_/ / /_/ / /_/ / /_
#     (_)_.___/\__,_/____/_/ /_/____/_/\____/\__, /\____/\__,_/\__/
#                             /_____/       /____/
# full config can be found at: https://github.com/a2n-s/dotfiles

# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

echo ".bash_logout"
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
