#! /usr/bin/bash
#                        _       __             __                 __               __               __
#        _______________(_)___  / /______     _/_/           _____/ /_  ____  _____/ /__      ______/ /
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/            / ___/ __ \/ __ \/ ___/ __/ | /| / / __  /
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/             (__  ) / / / /_/ / /  / /_ | |/ |/ / /_/ /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     ______   /____/_/ /_/\____/_/   \__/ |__/|__/\__,_/
#                     /_/                       /_____/
#
# Description: gives a short directory in prompt, not to fill the entire line when inside nested directories.
# Dependencies:
# GitHub: https://github.com/a2n-s/dotfiles 
# License: https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

max_num_dirs=7
newPWD="${PWD/#$HOME/~}"
num_dirs=$(echo -n $newPWD | awk -F '/' '{print NF}')
if [ $num_dirs -gt $max_num_dirs ]; then
    newPWD="~$(echo -n $newPWD | awk -F '/' '{print $1 "/.../" $(NF-1) "/" $(NF)}')"
else
    newPWD=$(echo $newPWD | sed -e "s|$HOME|~|g")
fi
echo -n $newPWD
