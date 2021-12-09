#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __                 __                            __       __                  __
#        _______________(_)___  / /______     _/_/           _____/ /_____  ____ _      ______ _/ /______/ /_           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/            / ___/ __/ __ \/ __ \ | /| / / __ `/ __/ ___/ __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/             (__  ) /_/ /_/ / /_/ / |/ |/ / /_/ / /_/ /__/ / / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     ______   /____/\__/\____/ .___/|__/|__/\__,_/\__/\___/_/ /_/   (_)  /____/_/ /_/
#                     /_/                       /_____/                 /_/
#
# Description:  simple stopwatch
#               deprecated -> see termdown instead.
# Dependencies:
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

  date1=`date +%s`;
   while true; do
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
   done
