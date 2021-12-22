#! /usr/bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __        __           __                         __                __  
#        _______________(_)___  / /______     _/_/  _____/ /___  _____/ /__            __________/ /_         _____/ /_ 
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / ___/ / __ \/ ___/ //_/  ______   / ___/ ___/ __/        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    (__  ) / /_/ / /__/ ,<    /_____/  / /__(__  ) /_    _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /____/_/\____/\___/_/|_|            \___/____/\__/   (_)  /____/_/ /_/ 
#                     /_/                                                                                               
#
# Description:  a wrapper for slock which prints a fancy raibow cow on the lock screen.
# Dependencies: cowsay, fortune, locat.
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

slock -m "$(cowsay $(fortune -c) | lolcat -ft)"
