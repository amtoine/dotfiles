#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#                        _       __             __                                                                                    __     ____            ____           __                          __                  __
#        _______________(_)___  / /______     _/_/  ________  ____  ____           ________  ____  ____ _____ ___  ___           ____/ /__  / __/___ ___  __/ / /_         / /_  _________ _____  _____/ /_           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / ___/ _ \/ __ \/ __ \         / ___/ _ \/ __ \/ __ `/ __ `__ \/ _ \         / __  / _ \/ /_/ __ `/ / / / / __/        / __ \/ ___/ __ `/ __ \/ ___/ __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /  /  __/ /_/ / /_/ /   _    / /  /  __/ / / / /_/ / / / / / /  __/   _    / /_/ /  __/ __/ /_/ / /_/ / / /_    _    / /_/ / /  / /_/ / / / / /__/ / / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /_/   \___/ .___/\____/   (_)  /_/   \___/_/ /_/\__,_/_/ /_/ /_/\___/   (_)   \__,_/\___/_/  \__,_/\__,_/_/\__/   (_)  /_.___/_/   \__,_/_/ /_/\___/_/ /_/   (_)  /____/_/ /_/
#                     /_/                                 /_/
#
# Description:  rename the default branch automaticcaly.
#               By default, rename master into main on the remote origin.
#               The above can be changed with `OLD=<old-branch> NEW=<new-branch> REM=<remote> repo.rename.default.branch.sh`
# Dependencies: git
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

[[ ! -v OLD ]] && OLD="master"
[[ ! -v NEW ]] && NEW="main"
[[ ! -v REM ]] && REM="origin"

echo "$REM: $OLD -> $NEW"

git branch -m "$OLD" "$NEW"
git fetch "$REM" -p
git branch -u "$REM"/"$NEW" "$NEW"
git remote set-head "$REM" -a
