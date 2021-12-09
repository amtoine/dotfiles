#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __                                                         _ __              _       ____                    __
#        _______________(_)___  / /______     _/_/           ____  ____ ______________              ____ _(_) /_            (_)___  / __/___           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/            / __ \/ __ `/ ___/ ___/ _ \            / __ `/ / __/           / / __ \/ /_/ __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/             / /_/ / /_/ / /  (__  )  __/           / /_/ / / /_            / / / / / __/ /_/ /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     ______   / .___/\__,_/_/  /____/\___/  ______    \__, /_/\__/  ______   /_/_/ /_/_/  \____/   (_)  /____/_/ /_/
#                     /_/                       /_____/  /_/                           /_____/   /____/        /_____/

#
# Description:  gives information about the current git repository.
#               for example, let us say that one is in a repo called 'repo' coming from user 'user', i.e. URL with user/repo on GitHub.
#               at current time, one is on the branch 'branch' and the repo has got 1 file to be commited, 2 files not staged for commits,
#               3 untracked files and no stash, then the output of _parse_git_info will be:
#                  (repo@branch:1,2,3,0)
# Dependencies: git
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

git branch 1> /dev/null 2> /dev/null
if [ $? -eq 0 ]; then
  branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')                                                                  # the active branch name.
  tbc=$(git status 2> /dev/null | awk '/^Changes to be committed/,/^$/' | grep -e $'^\t' | wc -l)                                            # the numbers of files to be commited (tbc).
  nsfc=$(git status 2> /dev/null | awk '/^Changes not staged for commit/,/^$/' | grep -e $'^\t' | wc -l)                                     # the numbers of files not staged for commit (nsfc).
  uf=$(git status 2> /dev/null | awk '/^Untracked files/,/^$/' | grep -e $'^\t' | wc -l)                                                     # the numbers of untracked files (uf).
  sl=$(git stash list 2> /dev/null | wc -l)                                                                                                  # the number of stashes.
  repo=$(git remote -v 2> /dev/null | grep -e "origin.*fetch"  | rev | cut -d'/' -f1 | rev | sed "s/ (fetch)//g; s/ (push)//g; s/\.git$//")  # the repo name.
  echo -e "\e[39m(\e[36m$repo\e[96m@\e[36m$branch\e[39m:\e[92m$tbc\e[39m,\e[93m$nsfc\e[39m,\e[91m$uf\e[39m,\e[95m$sl\e[39m)"
fi
