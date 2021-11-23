#!/bin/sh
#                        _       __             __                                       __          __                __
#        _______________(_)___  / /______     _/_/  __________________  ___  ____  _____/ /_  ____  / /_         _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / ___/ ___/ ___/ _ \/ _ \/ __ \/ ___/ __ \/ __ \/ __/        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    (__  ) /__/ /  /  __/  __/ / / (__  ) / / / /_/ / /_    _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /____/\___/_/   \___/\___/_/ /_/____/_/ /_/\____/\__/   (_)  /____/_/ /_/
#                     /_/
#
# takes a screenshot of all the screens with the 'full' flag and only a selected window with the 'window' flag.

screenshot() {
	case $1 in
	full)
		scrot -m '%Y-%m-%d_%H-%M-%S_$wx$h_scrot.png' -e 'mv $f ~/images/shots/'
		;;
	window)
		sleep 1
		scrot -s '%Y-%m-%d_%H-%M-%S_$wx$h_scrot.png' -e 'mv $f ~/images/shots/'
		;;
	*)
		;;
	esac;
}

screenshot $1
