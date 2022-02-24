#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __        _                        _      _         _
#      ___   / /     __| |_ ___ _ ____ __ ____ _| |_ __| |_    __| |_
#     (_-<  / /     (_-<  _/ _ \ '_ \ V  V / _` |  _/ _| ' \ _(_-< ' \
#     /__/ /_/    __/__/\__\___/ .__/\_/\_/\__,_|\__\__|_||_(_)__/_||_|
#                |___|         |_|
#
# Description:  simple stopwatch
#               deprecated -> see termdown instead.
# Dependencies:
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

  date1=`date +%s`;
   while true; do
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
   done
