#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                               _____             __                   ____      __                  _       __             __            ___ __                                                         __
#             _________  ____  / __(_)___ _     _/_/  _______  _______/ __/    _/_/  _______________(_)___  / /______     _/_/  ___  ____/ (_) /_          __________________  ___  ____           _____/ /_
#            / ___/ __ \/ __ \/ /_/ / __ `/   _/_/   / ___/ / / / ___/ /_    _/_/   / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / _ \/ __  / / __/         / ___/ ___/ ___/ _ \/ _ \/ __ \         / ___/ __ \
#      _    / /__/ /_/ / / / / __/ / /_/ /  _/_/    (__  ) /_/ / /  / __/  _/_/    (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    /  __/ /_/ / / /_     _    (__  ) /__/ /  /  __/  __/ / / /   _    (__  ) / / /
#     (_)   \___/\____/_/ /_/_/ /_/\__, /  /_/     /____/\__,_/_/  /_/    /_/     /____/\___/_/  /_/ .___/\__/____/  /_/      \___/\__,_/_/\__/    (_)  /____/\___/_/   \___/\___/_/ /_/   (_)  /____/_/ /_/
#                                 /____/                                                          /_/
#
# Description:  Should open the source code a the cuttent surf page in the $EDITOR. NOT WORKING.
# Dependencies: kitty
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

tmpfile=$(mktemp /tmp/surf-edit.XXXXXX)
trap  'rm "$tmpfile"' 0 1 15
cat > "$tmpfile"

# kitty "$EDITOR" "$tmpfile"
kitty nvim "$tmpfile"
