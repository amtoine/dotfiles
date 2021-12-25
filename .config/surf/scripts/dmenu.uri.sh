#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                         ____      __                  _       __             __       __                                               _               __
#        _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ____/ /___ ___  ___  ____  __  __         __  _______(_)        _____/ /_
#       / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __  / __ `__ \/ _ \/ __ \/ / / /        / / / / ___/ /        / ___/ __ \
#      (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / / / / / /  __/ / / / /_/ /   _    / /_/ / /  / /   _    (__  ) / / /
#     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \__,_/_/ /_/ /_/\___/_/ /_/\__,_/   (_)   \__,_/_/  /_/   (_)  /____/_/ /_/
#                                                    /_/
#
# Description:  Opens the history to allow the user to go back in time with surf.
# Dependencies: tac, dmenu
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

tac ~/.config/surf/history.txt | dmenu -l 10 -b -i | awk '{ print $2 }'
