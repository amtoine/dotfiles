#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#          _               _                _                         _
#         | |             | |              | |                       | |
#         | |__   __ _ ___| |__            | | ___   __ _  ___  _   _| |_
#         | '_ \ / _` / __| '_ \           | |/ _ \ / _` |/ _ \| | | | __|
#      _  | |_) | (_| \__ \ | | |          | | (_) | (_| | (_) | |_| | |_
#     (_) |_.__/ \__,_|___/_| |_|          |_|\___/ \__, |\___/ \__,_|\__|
#                                  ______            __/ |
#                                 |______|          |___/
#
# Description:  ~/.bash_logout: executed by bash(1) when login shell exits.
# Dependencies:
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

# when leaving the console clear the screen to increase privacy

echo "$HOME/.bash_logout"
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
