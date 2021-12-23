#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                         ____      __                  _       __             __            ___ __           __                __                        __                      __
#        _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ___  ____/ (_) /_         / /_  ____  ____  / /______ ___  ____ ______/ /_______         _____/ /_
#       / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / _ \/ __  / / __/        / __ \/ __ \/ __ \/ //_/ __ `__ \/ __ `/ ___/ //_/ ___/        / ___/ __ \
#      (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    /  __/ /_/ / / /_    _    / /_/ / /_/ / /_/ / ,< / / / / / / /_/ / /  / ,< (__  )   _    (__  ) / / /
#     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \___/\__,_/_/\__/   (_)  /_.___/\____/\____/_/|_/_/ /_/ /_/\__,_/_/  /_/|_/____/   (_)  /____/_/ /_/
#                                                    /_/
#
# Description:  Opens the bookmarks file in the $EDITOR.
# Dependencies: kitty
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

bookmarks="$HOME/.config/surf/bookmarks"
# kitty "$EDITOR" "$bookmarks"
kitty nvim "$bookmarks"
