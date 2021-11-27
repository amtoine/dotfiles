#! /usr/bin/bash
#                        _       __             __                                                         _ __             _       ____
#        _______________(_)___  / /______     _/_/           ____  ____ ______________              ____ _(_) /_           (_)___  / __/___
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/            / __ \/ __ `/ ___/ ___/ _ \            / __ `/ / __/          / / __ \/ /_/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/             / /_/ / /_/ / /  (__  )  __/           / /_/ / / /_           / / / / / __/ /_/ /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     ______   / .___/\__,_/_/  /____/\___/  ______    \__, /_/\__/  ______  /_/_/ /_/_/  \____/
#                     /_/                       /_____/  /_/                           /_____/   /____/        /_____/
#
# Description: gives information about the current git repository.
# Dependencies: git
# GitHub: https://github.com/a2n-s/dotfiles 
# License: https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

git branch 1> /dev/null 2> /dev/null
if [ $? -eq 0 ]; then
  branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  tbc=$(git status 2> /dev/null | awk '/^Changes to be committed/,/^$/' | grep -e $'^\t' | wc -l)
  nsfc=$(git status 2> /dev/null | awk '/^Changes not staged for commit/,/^$/' | grep -e $'^\t' | wc -l)
  uf=$(git status 2> /dev/null | awk '/^Untracked files/,/^$/' | grep -e $'^\t' | wc -l)
  sl=$(git stash list 2> /dev/null | wc -l)
  repo=$(git remote -v 2> /dev/null | grep -e "origin.*fetch"  | rev | cut -d'/' -f1 | rev | sed "s/ (fetch)//g; s/ (push)//g; s/\.git$//")
  echo -e "\e[39m(\e[36m$repo\e[96m@\e[36m$branch\e[39m:\e[92m$tbc\e[39m,\e[93m$nsfc\e[39m,\e[91m$uf\e[39m,\e[95m$sl\e[39m)"
fi
