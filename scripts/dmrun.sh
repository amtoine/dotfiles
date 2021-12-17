#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __       __                                         __ 
#        _______________(_)___  / /______     _/_/  ____/ /___ ___  _______  ______           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / __  / __ `__ \/ ___/ / / / __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / / / / / / /  / /_/ / / / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \__,_/_/ /_/ /_/_/   \__,_/_/ /_/   (_)  /____/_/ /_/
#                     /_/
#
# Description:  wrapper around dmenu_run to launch dmenu in the middle and in a grid fashion.
# Dependencies: dmenu
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

DMWIDTH=700; \
DMHEIGHT=10; \
DMCOLUMNS=3; \
DMLINES=9; \
DMBORDER=5; \
dmenu_run -g $DMCOLUMNS -l $DMLINES \
          -x $((960 - $DMWIDTH/2)) -y $((540 - ($DMLINES+1)*$DMHEIGHT/2)) \
          -z $DMWIDTH -h $DMHEIGHT -bw $DMBORDER
