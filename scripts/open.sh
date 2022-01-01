#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __                                        __
#        _______________(_)___  / /______     _/_/  ____  ____  ___  ____           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __ \/ __ \/ _ \/ __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / /_/ /  __/ / / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \____/ .___/\___/_/ /_/   (_)  /____/_/ /_/
#                     /_/                             /_/
#
# Description:  tries to replace a tiny part of xdg-open as it does not behave as I want.
# Dependencies: kitty, feh, okular
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

TERMINAL="kitty"
BROWSER="surf"

[[ $1 =~ http* ]] && { $BROWSER $1; exit 0; }

case $(file --mime-type $1 -b) in
  text/*) $TERMINAL $EDITOR $1;;
  image/*) feh $1;;
  */pdf) $TERMINAL okular $1;;
  *) exit 1;;
esac
