#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __   ___      __                 _ __                                                      ___                              __  _              __  
#        _______________(_)___  / /______     _/_/  / (_)____/ /_         ____ _(_) /_            ________  ____  ____  _____         ____/ (_)___ _____ _____  ____  _____/ /_(_)____   _____/ /_ 
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / / / ___/ __/        / __ `/ / __/  ______   / ___/ _ \/ __ \/ __ \/ ___/        / __  / / __ `/ __ `/ __ \/ __ \/ ___/ __/ / ___/  / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / / (__  ) /_    _    / /_/ / / /_   /_____/  / /  /  __/ /_/ / /_/ (__  )   _    / /_/ / / /_/ / /_/ / / / / /_/ (__  ) /_/ / /__   (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /_/_/____/\__/   (_)   \__, /_/\__/           /_/   \___/ .___/\____/____/   (_)   \__,_/_/\__,_/\__, /_/ /_/\____/____/\__/_/\___/  /____/_/ /_/ 
#                     /_/                                              /____/                           /_/                                      /____/                                            
#
# Description:  gives a complete overview of all the active repos on the system.
# Dependencies: repo.info.sh
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

RES="Repos: remote@branch:staged,unstaged,untracked,stashed";
RES=$RES\\n"-----------------------: -----------------------@------:------,--------,---------,-------";
for repo in $(find $pwd -type d | grep "\.git\$" | sed 's/\/\.git//' | grep -v ".local" | grep -v "^./.cache" | grep -v "^./.vim" | grep -v "^./torch" | grep -v "^./.cargo"); do
  tmp=$(repo.info.sh $repo)
  RES=$RES\\n$tmp
done;
echo -e $RES | grep -v ":0,0,0,0)" | sed 's/://; s/(//g; s/)//g;' \
             | sed 's/ /\&| /' | column -t -s '&' \
             | sed 's/@/\&| /' | column -t -s '&' \
             | sed 's/:/\&| /' | column -t -s '&' \
             | sed 's/,/\&| /' | column -t -s '&' \
             | sed 's/,/\&| /' | column -t -s '&' \
             | sed 's/,/\&| /' | column -t -s '&' \
             | sed 's/  | / | /g'
