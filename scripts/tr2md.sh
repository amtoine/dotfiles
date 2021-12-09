#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __   __      ___                 __              __
#        _______________(_)___  / /______     _/_/  / /_____|__ \ ____ ___  ____/ /        _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __/ ___/_/ // __ `__ \/ __  /        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ /  / __// / / / / / /_/ /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \__/_/  /____/_/ /_/ /_/\__,_/   (_)  /____/_/ /_/
#                     /_/
#
# Description:  turns the tree architecture of a directory into a usable one inside a markdown file.
#               WORK IN PROGRESS.
# Dependencies: tree
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

# name=$(pwd | rev | cut -d'/' -f1 | rev)
# tree -p --filelimit 29 -L 3 | sed "s/^\./📦 $name/g; \
#                                    s/├/┣/g; \
#                                    s/─ \[d.*\] / 📂/g; \
#                                    s/─ \[-.*\] / 📜/g; \
#                                    s/─ \[l.*\] / 📜/g; \
#                                    s/─/━/g; \
#                                    s/│/┃/g; \
#                                    s/└/┗/g; \
#                                    s/┃\s\s\s/\s\s\s\s\s\s/g; \
#                                    s/$/  /g" \
#                                > tree.md
tree -apI .git --dirsfirst | sed 's/\[\(.\).........\]/[\1]/;'
