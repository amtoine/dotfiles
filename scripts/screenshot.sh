#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __                                       __          __                __
#        _______________(_)___  / /______     _/_/  __________________  ___  ____  _____/ /_  ____  / /_         _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / ___/ ___/ ___/ _ \/ _ \/ __ \/ ___/ __ \/ __ \/ __/        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    (__  ) /__/ /  /  __/  __/ / / (__  ) / / / /_/ / /_    _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /____/\___/_/   \___/\___/_/ /_/____/_/ /_/\____/\__/   (_)  /____/_/ /_/
#                     /_/
#
# Description:  takes a screenshot of all the screens with the 'full' flag and only a selected window with the 'window' flag.
#               '$SCRIPTS/screenshot.sh full' will take a screenshot of the whole screen.
#               '$SCRIPTS/screenshot.sh window' will let the user chose the window he wants to take a screenshot of.
# Dependencies: scrot
# License:      https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

screenshot() {
	case $1 in
	full)
		scrot -m '%Y-%m-%d_%H-%M-%S_$wx$h_scrot.png' -e 'mv $f ~/imgs/shots/'
		;;
	window)
		sleep 1
		scrot -s '%Y-%m-%d_%H-%M-%S_$wx$h_scrot.png' -e 'mv $f ~/imgs/shots/'
		;;
	*)
		;;
	esac;
}

screenshot $1
