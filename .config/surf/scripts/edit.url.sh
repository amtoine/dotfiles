#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://amtoine.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/amtoine 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/amtoine/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                               _____             __                   ____      __                  _       __             __            ___ __             __              __
#             _________  ____  / __(_)___ _     _/_/  _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ___  ____/ (_) /___  _______/ /        _____/ /_
#            / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / _ \/ __  / / __/ / / / ___/ /        / ___/ __ \
#      _    / /__/ /_/ / / / / __/ / /_/ /  _/_/    (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    /  __/ /_/ / / /_/ /_/ / /  / /   _    (__  ) / / /
#     (_)   \___/\____/_/ /_/_/ /_/\__, /  /_/     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \___/\__,_/_/\__/\__,_/_/  /_/   (_)  /____/_/ /_/
#                                 /____/                                                          /_/
#
# Description:  Should open the source code a the cuttent surf page in the $EDITOR. NOT WORKING.
# Dependencies: sselp, kitty
# License:      https://github.com/amtoine/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

dir=~/.config/surf/tmpedit
name=`ls $dir | wc -l`
file=$dir/$name.html
sselp > $file && kitty $EDITOR $file
