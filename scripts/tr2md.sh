#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __  _               ___          _      _
#      ___   / / | |_ _ _ ___ ___|_  )_ __  __| |  __| |_
#     (_-<  / /  |  _| '_/ -_) -_)/ /| '  \/ _` |_(_-< ' \
#     /__/ /_/    \__|_| \___\___/___|_|_|_\__,_(_)__/_||_|
#
# Description:  turns the tree architecture of a directory into a usable one inside a markdown file.
#               WORK IN PROGRESS.
# Dependencies: tree
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
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
