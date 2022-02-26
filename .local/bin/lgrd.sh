#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __  _             _      _
#      ___   / / | |__ _ _ _ __| |  __| |_
#     (_-<  / /  | / _` | '_/ _` |_(_-< ' \
#     /__/ /_/   |_\__, |_| \__,_(_)__/_||_|
#                  |___/
#
# Description:  gives a complete overview of all the active repos on the system.
# Dependencies: _repo.info.sh
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

tmpfile=$(mktemp /tmp/repo.diag.XXXXXX)
trap  'rm "$tmpfile"' 0 1 15

echo "repo,remote,branch,staged,unstaged,untracked,stashed" > $tmpfile

echo "Fetching repos from $(pwd) ..."
for repo in $(find $pwd -type d | grep "\.git\$" | sed 's/\/\.git//' | grep -v ".local" | grep -v "^./.cache" | grep -v "^./.vim" | grep -v "^./torch" | grep -v "^./.cargo"); do
  echo -ne "treating: $repo                                         \r"
  _repo.info.sh $repo >> $tmpfile
done
sed -i 's/@/,/g; s/: */,/g; s/(//g; s/)//g;' $tmpfile
csvcut $tmpfile | csvlook -I | less -S
