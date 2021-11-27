#! /usr/bin/bash
#                        _       __             __   __                ___                 __
#        _______________(_)___  / /______     _/_/  / /_________  ___ |__ \ ____ ___  ____/ /
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __/ ___/ _ \/ _ \__/ // __ `__ \/ __  /
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ /  /  __/  __/ __// / / / / / /_/ /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \__/_/   \___/\___/____/_/ /_/ /_/\__,_/
#                     /_/
# Description: turns the tree architecture of a directory into a usable one inside a markdown.
#              WORK IN PROGRESS.
# Dependencies: tree
# GitHub: https://github.com/a2n-s/dotfiles 
# License: https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

name=$(pwd | rev | cut -d'/' -f1 | rev)
tree -p --filelimit 29 -L 3 | sed "s/^\./📦 $name/g; \
                                   s/├/┣/g; \
                                   s/─ \[d.*\] / 📂/g; \
                                   s/─ \[-.*\] / 📜/g; \
                                   s/─ \[l.*\] / 📜/g; \
                                   s/─/━/g; \
                                   s/│/┃/g; \
                                   s/└/┗/g; \
                                   s/┃\s\s\s/\s\s\s\s\s\s/g; \
                                   s/$/  /g" \
                               > tree.md
#tree -apI .git --dirsfirst | sed 's/\[\(.\).........\]/[\1]/;'
