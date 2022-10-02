#             ___
#       ____ |__ \ ____              _____      personal page: https://amtoine.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/amtoine 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/amtoine/dotfiles 
#     \__,_/____/_/ /_/           /____/
#          _               _                                 __ _ _
#         | |             | |                               / _(_) |
#         | |__   __ _ ___| |__             _ __  _ __ ___ | |_ _| | ___
#         | '_ \ / _` / __| '_ \           | '_ \| '__/ _ \|  _| | |/ _ \
#      _  | |_) | (_| \__ \ | | |          | |_) | | | (_) | | | | |  __/
#     (_) |_.__/ \__,_|___/_| |_|          | .__/|_|  \___/|_| |_|_|\___|
#                                  ______  | |
#                                 |______| |_|
#
# Description:  my bash profile.
# Dependencies:
# License:      https://github.com/amtoine/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

echo "$HOME/.bash_profile"
[ ! -s ~/.config/mpd/pid ] && mpd
if [[ $(fgconsole 2> /dev/null) == 1 ]]; then
    echo "Starting x..."
    exec startx -- vt1;
else
  [[ -f ~/.bashrc ]] && . ~/.bashrc
fi

source /home/amtoine/.config/broot/launcher/bash/br
