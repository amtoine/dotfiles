#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                         ____      __                  _       __             __            ___ __             __              __
#        _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ___  ____/ (_) /___  _______/ /        _____/ /_
#       / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / _ \/ __  / / __/ / / / ___/ /        / ___/ __ \
#      (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    /  __/ /_/ / / /_/ /_/ / /  / /   _    (__  ) / / /
#     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \___/\__,_/_/\__/\__,_/_/  /_/   (_)  /____/_/ /_/
#                                                    /_/
#
# Description:  Should open the source code a the cuttent surf page in the $EDITOR. NOT WORKING.
# Dependencies: sselp, kitty
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

dir=~/.config/surf/tmpedit
name=`ls $dir | wc -l`
file=$dir/$name.html
sselp > $file && kitty vim $file
