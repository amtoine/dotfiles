#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://amtoine.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/amtoine 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/amtoine/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                               _____             __   ______      __                  _       __             __        __                                         __
#             _________  ____  / __(_)___ _     _/_/  / / __/    _/_/  _______________(_)___  / /______     _/_/  _____/ /__  ____ _____  ___  _____         _____/ /_
#            / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / / /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / ___/ / _ \/ __ `/ __ \/ _ \/ ___/        / ___/ __ \
#      _    / /__/ /_/ / / / / __/ / /_/ /  _/_/    / / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /__/ /  __/ /_/ / / / /  __/ /      _    (__  ) / / /
#     (_)   \___/\____/_/ /_/_/ /_/\__, /  /_/     /_/_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \___/_/\___/\__,_/_/ /_/\___/_/      (_)  /____/_/ /_/
#                                 /____/                                             /_/
#
# Description:  cleans the current preview for next one or other graphical applications.
# Dependencies: implicitely ueberzug
# License:      https://github.com/amtoine/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine
#               cirala -> https://github.com/cirala/lfimg/blob/master/cleaner 

if [ -n "$FIFO_UEBERZUG" ]; then
	printf '{"action": "remove", "identifier": "PREVIEW"}\n' > "$FIFO_UEBERZUG"
fi
