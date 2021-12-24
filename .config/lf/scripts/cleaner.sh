#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#         ______      __                  _       __             __        __                                         __
#        / / __/    _/_/  _______________(_)___  / /______     _/_/  _____/ /__  ____ _____  ___  _____         _____/ /_
#       / / /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / ___/ / _ \/ __ `/ __ \/ _ \/ ___/        / ___/ __ \
#      / / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /__/ /  __/ /_/ / / / /  __/ /      _    (__  ) / / /
#     /_/_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \___/_/\___/\__,_/_/ /_/\___/_/      (_)  /____/_/ /_/
#                                      /_/
#
# Description:  cleans the current preview for next one or other graphical applications.
# Dependencies: implicitely ueberzug
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine
#               cirala -> https://github.com/cirala/lfimg/blob/master/cleaner 

if [ -n "$FIFO_UEBERZUG" ]; then
	printf '{"action": "remove", "identifier": "PREVIEW"}\n' > "$FIFO_UEBERZUG"
fi
