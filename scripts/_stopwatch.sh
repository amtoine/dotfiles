#! /usr/bin/bash
#                        _       __             __                 __                            __       __
#        _______________(_)___  / /______     _/_/           _____/ /_____  ____ _      ______ _/ /______/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/            / ___/ __/ __ \/ __ \ | /| / / __ `/ __/ ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/             (__  ) /_/ /_/ / /_/ / |/ |/ / /_/ / /_/ /__/ / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     ______   /____/\__/\____/ .___/|__/|__/\__,_/\__/\___/_/ /_/
#                     /_/                       /_____/                 /_/
#
# Description: simple stopwatch
#              deprecated -> see termdown instead.
# Dependencies:
# GitHub: https://github.com/a2n-s/dotfiles 
# License: https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

  date1=`date +%s`;
   while true; do
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
   done
