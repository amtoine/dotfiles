#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __             _                                  _                _
#      ___   / /     _ ___ _(_)_ __ ___ _ _ ___ _ _  __ _ _ __ (_)_ _  __ _   __| |_
#     (_-<  / /     | ' \ V / | '  \___| '_/ -_) ' \/ _` | '  \| | ' \/ _` |_(_-< ' \
#     /__/ /_/    __|_||_\_/|_|_|_|_|  |_| \___|_||_\__,_|_|_|_|_|_||_\__, (_)__/_||_|
#                |___|                                                |___/
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

