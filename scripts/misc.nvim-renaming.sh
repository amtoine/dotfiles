#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __             _                               _                                                       _                           __  
#        _______________(_)___  / /______     _/_/  ____ ___  (_)_________         ____ _   __(_)___ ___              ________  ____  ____ _____ ___  (_)___  ____ _         _____/ /_ 
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __ `__ \/ / ___/ ___/        / __ \ | / / / __ `__ \   ______   / ___/ _ \/ __ \/ __ `/ __ `__ \/ / __ \/ __ `/        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / / / / / / (__  ) /__    _    / / / / |/ / / / / / / /  /_____/  / /  /  __/ / / / /_/ / / / / / / / / / / /_/ /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /_/ /_/ /_/_/____/\___/   (_)  /_/ /_/|___/_/_/ /_/ /_/           /_/   \___/_/ /_/\__,_/_/ /_/ /_/_/_/ /_/\__, /   (_)  /____/_/ /_/ 
#                     /_/                                                                                                                                  /____/                      
#
# Description:  another template to replace easily the headers of my files with the new more standard one I use (the one just above).
# Dependencies: ~/.script.template.sh
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

for file in $(tree -f | grep "lua.*\.lua$" | sed 's/.*\.\/lua\/user/.\/lua\/user/'); do
  mv $file $file.old
  touch $file
  head ~/.script.template.sh -n 6 | tail -n 5 >> $file
  figlet -tf slant $(echo $file | sed 's/\./ . /g; s/\// \/ /g; s/-/ - /g; s/_/ _ /g') >> $file
  tail ~/.script.template.sh -n 6 | head -n 5 >> $file
  cat $file.old >> $file
  rm $file.old
  sed -i '6,11s/^/--     /; 6,11s/\s\+$//; s/^#/--/' $file
done

